class AkiDiagnosis < ActiveRecord::Base
  belongs_to :patient
  belongs_to :creatinine_test_1, class_name: 'CreatinineTest', foreign_key: 'creatinine_test_1_id'
  belongs_to :creatinine_test_2, class_name: 'CreatinineTest', foreign_key: 'creatinine_test_2_id'

  after_initialize :set_fields
  before_save :set_fields

  validates_uniqueness_of :creatinine_test_1_id, scope: :creatinine_test_2_id

  def self.at_day(date)
    return where(discovered_at: (date.beginning_of_day..date.end_of_day))
  end

  def self.at_month_of_year(month, year)
    refenrece_date = Date.new(year, month, 1)
    where(discovered_at: (refenrece_date.beginning_of_month..refenrece_date.end_of_month))
  end

  private
    def set_fields
      self.patient = creatinine_test_1.patient
      self.discovered_at = creatinine_test_2.performed_at
      self.increase_net = creatinine_test_2.level - creatinine_test_1.level
      self.increase_percentage = self.increase_net*100/creatinine_test_1.level
      self.discovered_at = creatinine_test_2.performed_at
      self.time_between_tests = creatinine_test_2.performed_at - creatinine_test_1.performed_at
    end
    
end
