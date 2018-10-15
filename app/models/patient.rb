class Patient < ActiveRecord::Base
  belongs_to :institution

  has_many :creatinine_tests, dependent: :destroy
  has_many :aki_diagnoses, dependent: :destroy
  has_many :epicrises, dependent: :destroy
  has_many :parameter_groups, dependent: :destroy

  has_many :alerts, dependent: :destroy

  validates_uniqueness_of :private_id, scope: :institution_id
  validates :private_id, :institution, presence: true
  validates :private_id, uniqueness: { scope: :institution_id }

  def to_s
    name.split(' ').map(&:capitalize).join(' ')
  end

  def worst_alert_kinds
    self.alerts.joins(:alert_kind).group(:alert_kind_id).maximum('alert_kinds.severity')
  end

  def worst_aki_stage
    ds = aki_diagnoses
    if ds.any?
      ds = ds.order("stage DESC")
      return ds.first.stage
    else
      return "none"
    end
  end

  def latest_aki_stage
    ds = aki_diagnoses
    if ds.any?
      ds = ds.order("discovered_at DESC")
      return ds.first.stage
    else
      return "none"
    end
  end

  # TODO: This can be a lot more efficient
  def self.average_age(patients)
    if patients.blank?
      '-'
    else
      sum_age = 0
      patients.each do |patient|
        sum_age += patient.age
      end

      sum_age/patients.count
    end
  end

  def age
    if birthday
      now = Time.now.utc.to_date
      now.year - birthday.year - (birthday.to_date.change(:year => now.year) > now ? 1 : 0)
    else
      nil
    end
  end

  def first_exam_date
    ct = creatinine_tests
    if ct.any?
      ct = ct.order("performed_at ASC")
      return ct.first.performed_at
    else
      return nil
    end
  end

  def last_exam_date
    ct = creatinine_tests
    if ct.any?
      ct = ct.order("performed_at DESC")
      return ct.first.performed_at
    else
      return nil
    end
  end
end
