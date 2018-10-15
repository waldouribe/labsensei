# encoding: utf-8
module ChartsHelper
  def values_for_chart(parameters)
    data = []

    parameters.each do |parameter|
      value = parameter.value

      # Check if value is boolean no me gusta.
      # hay que ver una forma mejor de representar booleans hay que ver una forma d
      if !!value == value
        value = value ? 1 : 0
      end

      data << {y: parameter.date.strftime("%Y-%m-%d %H:%M"),
        value: value
      }
    end

    return data
  end

  def values_for_multichart(a_parameters_array)
    data = []

    date_values = Hash.new

    a_parameters_array.each do |parameters|
      parameters.each do |parameter|
        value = parameter.value
        date = parameter.date.strftime("%Y-%m-%d %H:%M")

        # Check if value is boolean
        if !!value == value
          value = value ? 1 : 0
        end

        if date_values[date]
          puts 'exists'
          date_values[date] << { id: parameter.parameter_kind.id, value: value }
        else
          puts 'dont exists'
          date_values[date] = [{ id: parameter.parameter_kind.id, value: value }]
        end
      end
    end

    date_values.each do |date, values_array|
      dot = Hash.new
      dot[:y] = date

      values_array.each do |date_value|
        dot[date_value[:id]] = date_value[:value]
      end

      data << dot
    end

    return data
  end

  def label_for_chart(parameters)
    parameters.first.parameter_kind.units
  end

  def labels_for_multichart(a_parameters_array)
    labels = []
    a_parameters_array.each do |parameters|
      if parameters.present?
        labels << parameters.first.parameter_kind.name + " [" + parameters.first.parameter_kind.units + "]"
      end
    end

    return labels
  end

  def keys_for_multichart(a_parameters_array)
    keys = []
    a_parameters_array.each do |parameters|
      if parameters.present?
        keys << parameters.first.parameter_kind.id
      end
    end

    return keys
  end

  def tests_chart_data(patient)
    data = []
    patient.creatinine_tests.each do |t|
      data << {
               y: t.performed_at.strftime("%Y-%m-%d %H:%M"),
               level: t.level}
    end
    return data
  end

  def episodes_by_stage_data
    data = []
    total_episodes = 0

    (1..3).each do |stage|
      episodes = AkiDiagnosis.joins(:patient).where('stage = ? AND institution_id = ?', stage, @institution).count('distinct patient_id')
      data << { label: "Etapa #{stage}",
                value: episodes }
      total_episodes += episodes
    end

    data.each do |d|
      d['value'] = (1.0*d[:value]*100/total_episodes).round(1)
    end

    return data;
  end

  def episodes_by_age_data
    today = Date.today
    aki_0_14 = AkiDiagnosis.joins(:patient).where("institution_id = ? AND birthday >= ?", @institution, today - 14.years).group(:stage).count('distinct patient_id')
    aki_15_29 = AkiDiagnosis.joins(:patient).where("institution_id = ? AND birthday BETWEEN ? AND ?", @institution, today-29.years, today-15.years).group(:stage).count('distinct patient_id')
    aki_30_44 = AkiDiagnosis.joins(:patient).where("institution_id = ? AND birthday BETWEEN ? AND ?", @institution, today-44.years, today-30.years).group(:stage).count('distinct patient_id')
    aki_45_59 = AkiDiagnosis.joins(:patient).where("institution_id = ? AND birthday BETWEEN ? AND ?", @institution, today-59.years, today-45.years).group(:stage).count('distinct patient_id')
    aki_60_74 = AkiDiagnosis.joins(:patient).where("institution_id = ? AND birthday BETWEEN ? AND ?", @institution, today-74.years, today-60.years).group(:stage).count('distinct patient_id')
    aki_75_more = AkiDiagnosis.joins(:patient).where("institution_id = ? AND birthday <= ?", @institution, today - 75.years).group(:stage).count('distinct patient_id')

    data = []
    data << { x: "Menores de 14 años", stage_1: aki_0_14[1], stage_2: aki_0_14[2], stage_3: aki_0_14[3] }
    data << { x: "Entre 15 y 29 años", stage_1: aki_15_29[1], stage_2: aki_15_29[2], stage_3: aki_15_29[3] }
    data << { x: "Entre 30 y 44 años", stage_1: aki_30_44[1], stage_2: aki_30_44[2], stage_3: aki_30_44[3] }
    data << { x: "Entre 45 y 59 años", stage_1: aki_45_59[1], stage_2: aki_45_59[2], stage_3: aki_45_59[3] }
    data << { x: "Entre 60 y 74 años", stage_1: aki_60_74[1], stage_2: aki_60_74[2], stage_3: aki_60_74[3] }
    data << { x: "Mayores de 75 años", stage_1: aki_75_more[1], stage_2: aki_75_more[2], stage_3: aki_75_more[3] }

    return data
  end

  def aki_by_gender_data
    aki_patient_count = AkiDiagnosis.joins(:patient).where('institution_id = ? AND stage >= 1', @institution, ).count('distinct patient_id')
    male_percent = (1.0*AkiDiagnosis.joins(:patient).where('institution_id = ? AND patients.gender = ?',  @institution, 'male').where('stage >= 1').count('distinct patient_id')*100 / aki_patient_count).round(1)
    female_percent = (1.0*AkiDiagnosis.joins(:patient).where('institution_id = ? AND patients.gender = ?',  @institution, 'female').where('stage >= 1').count('distinct patient_id')*100 / aki_patient_count).round(1)
    data = []
    data << { label: "Hombres", value: male_percent }
    data << { label: "Mujeres", value: female_percent }
    return data
  end

end
