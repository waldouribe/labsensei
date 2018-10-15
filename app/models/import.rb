class Import < ActiveRecord::Base
  belongs_to :institution
  belongs_to :user

  attr_accessor :file

  has_many :import_results, dependent: :destroy
  accepts_nested_attributes_for :import_results

  validates :file, presence: true

  def save
    spreadsheet = open_spreadsheet(file)

    row_count = spreadsheet.last_row# Header included

    header = spreadsheet.row(1)
    valid_rows = 0
    (2..row_count).each do |i|
      row = spreadsheet.row(i)
      trasposed_row = Hash[[header, row].transpose]
      row_hash = trasposed_row.to_hash

      patient = create_or_update_patient patient_params(row_hash)
      creatinine_test = save_creatinine_test creatinine_test_params(row_hash), patient

      import_result = set_import_result(header, i, row, patient, creatinine_test)
      valid_rows += 1 if import_result.is_valid
    end
    self.total_rows = row_count - 1
    self.valid_rows = valid_rows
    self.invalid_rows = total_rows - valid_rows
    super
  end

  def patient_params(hash)
    original_headers = patient_dictionary().map{|e| e[0]}.uniq
    hash = Hash[hash.map { |key, value| [key.downcase, value.to_s] }]
    hash = hash.slice *original_headers
    hash =  Hash[hash.map { |key, value| [patient_dictionary[key]||key, value] }]
    return hash
  end

  def creatinine_test_params(hash)
    creatinine_test_headers = creatinine_test_dictionary.map{|e| e[0]}
    hash = Hash[hash.map { |key, value| [key.downcase, value.to_s] }]
    hash = hash.slice *creatinine_test_headers
    return Hash[hash.map { |key, value| [creatinine_test_dictionary[key]||key, value] }]
  end

  def set_import_result(headers, row_number, row, patient, creatinine_test)
    valid_row = (patient.valid? and creatinine_test.valid?)

    import_result = ImportResult.new(
      row_number: row_number,
      patient: patient,
      creatinine_test: creatinine_test,
      is_valid: valid_row
    )

    headers.each_with_index do |header, index|
      original_header = header
      header = header.downcase
      is_valid = true
      error = nil

      if patient.invalid? and patient_dictionary()[header].present?
        translated_header_sym = patient_dictionary()[header].to_sym
        if (patient.errors.messages[translated_header_sym]).present?
          is_valid = false
          error = patient.errors.messages[translated_header_sym][0]
        end
      end

      if creatinine_test.invalid? and creatinine_test_dictionary()[header].present?
        translated_header_sym = creatinine_test_dictionary()[header].to_sym
        if (creatinine_test.errors.messages[translated_header_sym]).present?
          is_valid = false
          error = creatinine_test.errors.messages[translated_header_sym][0]
        end
      end

      import_result.columns.new(
        column_name: original_header,
        column_number: index+1,
        value: row[index],
        is_valid: is_valid,
        error: error
      )
    end

    self.import_results << import_result
    return import_result
  end

  def open_spreadsheet(file)
    case File.extname(file.original_filename)
      when '.csv' then Roo::CSV.new(file.path, csv_options: { encoding: Encoding::ISO_8859_1 })
      when '.xls' then Roo::Excel.new(file.path)
      when '.xlsx' then Roo::Excelx.new(file.path)
      else raise "Tipo de archivo desconocido: #{file.original_filename}"
    end
  end

  def create_or_update_patient(a_patient_params)
    patient = Patient.find_or_initialize_by(
      institution: institution,
      private_id: a_patient_params['private_id'])
    a_patient_params['gender'] = parse_gender a_patient_params['gender']
    a_patient_params['birthday'] = parse_date a_patient_params['birthday']
    patient.update(a_patient_params)
    return patient
  end

  def save_creatinine_test(a_creatinine_test_params, patient)
    a_creatinine_test_params['institution_id'] = institution.id
    a_creatinine_test_params['performed_at'] = parse_datetime a_creatinine_test_params['performed_at']
    a_creatinine_test_params['level'] = parse_float a_creatinine_test_params['level']
    creatinine_test = CreatinineTest.new a_creatinine_test_params
    creatinine_test.patient = patient
    creatinine_test.save
    return creatinine_test
  end

  private
    def patient_dictionary
      return {
        'rut' => 'private_id',
        'identificador paciente' => 'private_id',
        'nombre' => 'name',
        'nombre paciente' => 'name',
        'fecha nacimiento' => 'birthday',
        'fecha nac.' => 'birthday',
        'fecha nac' => 'birthday',
        'fecha de nacimiento paciente' => 'birthday',
        'sexo' => 'gender',
        'genero paciente' => 'gender'
      }
    end

    def creatinine_test_dictionary
      return {
        'ot' => 'private_id',
        'identificador examen' => 'private_id',
        'fecha validacion' => 'performed_at',
        'fecha validación' => 'performed_at',
        'fecha validaci—n' => 'performed_at',
        'fecha examen' => 'performed_at',
        'crea' => 'level',
        'nivel creatinina' => 'level'
      }
    end

    def parse_gender(gender)
      gender_dictionary = {
        1 => 'male', 2 => 'female',
        '1' => 'male', '2' => 'female',
        'male' => 'male', 'female' => 'female',
        'masculino' => 'male', 'femenino' => 'male',
        'masc' => 'male', 'fem' => 'female',
        'hombre' => 'male', 'mujer' => 'female'
      }

      cleaned_gender = gender.downcase.strip
      return gender_dictionary[cleaned_gender] || gender
    end

    def parse_date(date_representation)
      return date_representation if date_representation.is_a? Date
      regexp_slash_dd_mm_yy = /\d{,2}\/\d{,2}\/\d{,2}/
      regexp_dash_dd_mm_yyyy = /\d{,2}-\d{,2}-\d{4}/
      regexp_dash_yyyy_mm_dd = /\d{,4}-\d{,2}-\d{2}/
      parsed_date = date_representation
      parsed_date = Date::strptime(date_representation, '%d/%m/%y') if regexp_slash_dd_mm_yy.match(date_representation)
      parsed_date = Date::strptime(date_representation, '%d-%m-%Y') if regexp_dash_dd_mm_yyyy.match(date_representation)
      parsed_date = Date::strptime(date_representation, '%Y-%m-%d') if regexp_dash_yyyy_mm_dd.match(date_representation)

      return parsed_date
    end

    def remove_leading_zeros(datetime_representation, delimiter)
      date_representation.split(delimiter)
    end

    def parse_datetime(datetime_representation)
      return datetime_representation if datetime_representation.is_a? DateTime
      regexp_y = /\d{,2}\/\d{,2}\/\d{2} \d{,2}:\d{,2}/
      regexp_Y = /\d{,2}\/\d{,2}\/\d{4} \d{,2}:\d{,2}/
      regexp_dash_yyyy_mm_dd = /\d{,4}-\d{,2}-\d{2} \d{,2}:\d{,2}/

      parsed_datetime = datetime_representation
      parsed_datetime = DateTime.strptime(datetime_representation, '%m/%d/%y %H:%M') if regexp_y.match(datetime_representation)
      parsed_datetime = DateTime.strptime(datetime_representation, '%m/%d/%Y %H:%M') if regexp_Y.match(datetime_representation)
      parsed_datetime = DateTime.strptime(datetime_representation, '%Y-%m-%d %H:%M') if regexp_dash_yyyy_mm_dd.match(datetime_representation)

      return parsed_datetime
    end

    def parse_float(float_representation)
      s = float_representation.to_s
      s = s.gsub(",", '.')
      if s.is_number?
        return s.to_f
      else
        return float_representation
      end
    end
end
