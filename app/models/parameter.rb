class Parameter < ActiveRecord::Base
  belongs_to :parameter_group
  belongs_to :parameter_kind

  has_one :patient, through: :parameter_group

  has_many :alerts, dependent: :destroy

  attr_accessor :raw_value

  before_save :set_value

  after_commit :execute_triggers

  def to_s
    value
  end

  def date
    parameter_group.date
  end

  def value
    case self.parameter_kind.parameter_type
    when 'string'
      self.value_string
    when 'decimal'
      self.value_decimal.round(2)
    when 'boolean'
      self.value_boolean
    when 'integer'
      self.value_integer
    else
      raise "Parameter type not supported: " + self.parameter_kind.parameter_type.to_s
    end
  end

  def execute_triggers
    parameter_kind.triggers.each do |trigger|
      trigger.execute(self)
    end
  end

  def worst_alert
    if alerts.present?
      alerts.joins(:alert_kind).order('alert_kinds.severity DESC').first
    else
      alerts
    end
  end


  private

    def set_value
      case self.parameter_kind.parameter_type
      when 'string'
        self.value_string = raw_value.to_s
      when 'decimal'
        self.value_decimal = raw_value.to_d
      when 'integer'
        self.value_integer = raw_value.to_i
      when 'boolean'
        self.value_boolean = raw_value
      else
        raise "Parameter type not supported: " + self.parameter_kind.parameter_type.to_s
      end
    end
end
