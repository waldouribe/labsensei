class Davila

  def self.change_name(parameter)
    parameter.patient.name = 'NAME CHANGED!'
    parameter.patient.save
  end
  
  def self.certican_low(parameter)
    alert_kind = AlertKind.find_by name: 'Certican bajo'
    if parameter.value < 3
      Alert.find_or_create_by(alert_kind: alert_kind, patient: parameter.patient, date: parameter.date, severity: 3)
    end
  end
  
  def self.certican_high(parameter)
    alert_kind = AlertKind.find_by name: 'Certican alto'
    if parameter.value > 8
      Alert.find_or_create_by(alert_kind: alert_kind, patient: parameter.patient, date: parameter.date, severity: 3)
    end
  end

  def self.rapamune_low(parameter)
    alert_kind = AlertKind.find_by name: 'Rapamune bajo'
    if parameter.value < 3
      Alert.find_or_create_by(alert_kind: alert_kind, patient: parameter.patient, date: parameter.date, severity: 3)
    end
  end

  def self.rapamune_high(parameter)
    alert_kind = AlertKind.find_by name: 'Rapamune alto'
    if parameter.value > 8
      Alert.find_or_create_by(alert_kind: alert_kind, patient: parameter.patient, date: parameter.date, severity: 3)
    end
  end

  def self.systolic_pressure_high(parameter)
    alert_kind = AlertKind.find_by name: 'Presión sistólica'
    if parameter.value > 160
      Alert.find_or_create_by(alert_kind: alert_kind, patient: parameter.patient, date: parameter.date, severity: 2)
    end
  end

  def self.diastolic_pressure_high(parameter)
    alert_kind = AlertKind.find_by name: 'Presión diastólica'
    if parameter.value > 100
      Alert.find_or_create_by(alert_kind: alert_kind, patient: parameter.patient, date: parameter.date, severity: 2)
    end
  end

  def self.calculate_proteinuria_creatinuria(parameter)
    proteinuria_parameter = parameter
    patient = parameter.patient
    parameter_group = parameter.parameter_group
    
    creatinuria_kind = ParameterKind.find_by name: 'Creatinuria'
    creatinuria_parameter = parameter_group.parameters.find_by parameter_kind: creatinuria_kind
    
    if creatinuria_parameter.present?
      value = proteinuria_parameter.value / creatinuria_parameter.value

      parameter_kind = ParameterKind.find_by name: 'Proteinuria / Creatinuria'
      proteinuria_creatinuria = Parameter.new parameter_group: parameter_group, parameter_kind: parameter_kind, raw_value: value
      proteinuria_creatinuria.save
    end
  end

  def self.proteinuria_creatinuria_high(parameter)
    alert_kind = AlertKind.find_by name: 'Proteinuria / Creatinuria'
    if parameter.value > 0.5
      Alert.find_or_create_by(alert_kind: alert_kind, patient: parameter.patient, date: parameter.date, severity: 3)
    end
  end

  def self.calculate_creatinina_basal(parameter)
    parameter_kind = ParameterKind.find_by name: 'Creatinina basal'
    
    creatinina_basal = Parameter.joins(:parameter_group).find_by('parameter_groups.patient_id' => parameter.patient, 
      'parameters.parameter_kind_id' => parameter_kind.id)

    if creatinina_basal.blank? or creatinina_basal.value > parameter.value
      creatinina_basal = Parameter.new parameter_group: parameter.parameter_group, parameter_kind: parameter_kind, raw_value: parameter.raw_value
      creatinina_basal.save
    end
  end

  def self.creatinina_high(parameter)
    alert_kind = AlertKind.find_by name: 'Creatinina alta'

    parameter_kind = ParameterKind.find_by name: 'Creatinina basal'
    
    creatinina_basal = Parameter.joins(:parameter_group).find_by('parameter_groups.patient_id' => parameter.patient.id, 'parameters.parameter_kind_id' => parameter_kind.id)

    if creatinina_basal.present? and parameter.value > creatinina_basal.value*1.2
      Alert.find_or_create_by(alert_kind: alert_kind, patient: parameter.patient, date: parameter.date, severity: 2)
    end
  end
end