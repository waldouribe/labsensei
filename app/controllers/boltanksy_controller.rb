class BoltanksyController < ApplicationController
  def new
  end

  def create
    spreadsheet = open_spreadsheet(boltansky_params[:file])
    row_count = spreadsheet.last_row# Header included
    header = spreadsheet.row(1)

    (2..row_count).each do |i|
      row = spreadsheet.row(i)
      trasposed_row = Hash[[header, row].transpose]
      patient = Patient.find_or_create_by patient_params(trasposed_row)
      (0..7).each do |day|
        creatinine = trasposed_row["Día #{day}"]
        days_ago = 10-day
        performed_at = DateTime.now() - days_ago.days
        if creatinine.present?
          creatinine_test = CreatinineTest.new(level: creatinine, 
            patient: patient, 
            private_id: "#{patient.private_id} / Día #{day}",
            performed_at: performed_at,
            institution_id: @institution.id)

          creatinine_test.save
        end
      end

      # if patient.creatinine_tests.empty?
      #   creatinine = trasposed_row["mg /dl"]
      #   performed_at = DateTime.now() - 10.days
      #   creatinine_test = CreatinineTest.new(level: creatinine, 
      #   patient: patient, 
      #   private_id: "#{patient.private_id} / Estimado",
      #   performed_at: performed_at,
      #   institution_id: @institution.id)

      #   creatinine_test.save
      # end

      # if patient.creatinine_tests.count == 1
      #   creatinine = trasposed_row["mg /dl"]
      #   performed_at = patient.creatinine_tests.first.performed_at - 1.day
      #   creatinine_test = CreatinineTest.new(level: creatinine, 
      #   patient: patient, 
      #   private_id: "#{patient.private_id} / Estimado",
      #   performed_at: performed_at,
      #   institution_id: @institution.id)

      #   creatinine_test.save
      # end
    end
  end

  def show
  end

  private 
    def open_spreadsheet(file)
      case File.extname(file.original_filename)
        when '.csv' then Roo::CSV.new(file.path, csv_options: { encoding: Encoding::ISO_8859_1 })
        when '.xls' then Roo::Excel.new(file.path)
        when '.xlsx' then Roo::Excelx.new(file.path)
        else raise "Tipo de archivo desconocido: #{file.original_filename}"
      end
    end

    def patient_params(row)
      birthday = Date.strptime(row['Fecha de nacimiento'], '%Y-%m-%d')
      {private_id: row['Identificador paciente'], 
      name: row['Identificador paciente'], 
      gender: row['Genero'], 
      birthday: birthday,
      institution_id: @institution.id
    }
    end

    def boltansky_params
      params.require(:boltanksy).permit(:file)
    end
end
