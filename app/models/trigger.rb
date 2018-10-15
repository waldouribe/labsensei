class Trigger < ActiveRecord::Base
  cattr_reader :KINDS
  @@KINDS = ['greater_than', 'lower_than', 'divide']
  
  validates :kind, inclusion: { in: @@KINDS }, unless: :is_custom

  belongs_to :parameter_kind
  belongs_to :arg0, :class_name => 'ParameterKind'
  belongs_to :arg1, :class_name => 'ParameterKind'
  belongs_to :alert_kind

  def execute(parameter)
    if is_custom
      klass = klass.constantize
      function = function

      klass.send(function, parameter)
    else
      case kind
      when 'greater_than'
        Alert.find_or_create_by(patient: parameter.patient, parameter: parameter, alert_kind: alert_kind, date: parameter.date) if parameter.value > self.value
      when 'lower_than'
        Alert.find_or_create_by(patient: parameter.patient, parameter: parameter, alert_kind: alert_kind, date: parameter.date) if parameter.value < self.value
      when 'divide'
        patient = parameter.patient
        numerator = parameter
        parameter_group = parameter.parameter_group
        denominator = parameter_group.parameters.find_by(parameter_kind: arg0)

        if denominator.present?
          ratio = numerator.value / denominator.value
          parameter_group.parameters.new(parameter_kind: arg1, raw_value: ratio)
          parameter_group.save
        end
      else
        raise "Kind not supported: #{kind}"
      end
    end
  end
end
