class Institution < ActiveRecord::Base
  has_many :patients, dependent: :destroy
  has_many :creatinine_tests, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :parameter_group_kinds, dependent: :destroy
  has_many :alert_kinds
  has_many :alerts, through: :alert_kinds
  belongs_to :plan

  PLAN_STATUS = %w[reached_global_quota reached_monthly_quota ok expired]

  before_create {
    set_default_plan_status
    set_default_active
  }

  def plan_status_symbols
    [plan_status.to_sym]
  end

  def plan_status?(plan_status)
    self.plan_status == plan_status.to_s
  end

  def set_default_plan_status
    self.plan_status ||= 'ok'
  end

  def set_default_active
    self.active ||= false
  end

  def to_s
    name
  end
end
