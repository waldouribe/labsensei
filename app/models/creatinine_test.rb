class CreatinineTest < ActiveRecord::Base
  belongs_to :patient
  belongs_to :institution

  has_many :base_level_aki_diagnosis, :class_name => 'AkiDiagnosis', :foreign_key => 'creatinine_test_1_id', dependent: :destroy
  has_many :final_level_aki_diagnosis, :class_name => 'AkiDiagnosis', :foreign_key => 'creatinine_test_2_id', dependent: :destroy

  after_create :save_aki_diagnosis

  validates :patient, :institution, :private_id, :performed_at, :level, presence: true
  validates :level, numericality: { greater_than: 0 }
  validates :private_id, uniqueness: { scope: :institution_id }

  def to_s
    level
  end

  def self.in_neighborhood(test_center, time_radius)
    left_border = test_center.performed_at - time_radius
    right_border = test_center.performed_at + time_radius
    ans = where("performed_at >= ? AND performed_at <= ?", left_border, right_border)
    ans = ans.where("id != ?", test_center.id)
    return ans
  end

  def self.at_month_of_year(month, year)
    refenrece_date = Date.new(year, month, 1)
    where(performed_at: (refenrece_date.beginning_of_month..refenrece_date.end_of_month))
  end

  private
    def save_aki_diagnosis
      aki_analyzer = AkiAnalyzer.new self
      aki_diagnosis = aki_analyzer.get_diagnosis
      if aki_diagnosis.present?
        aki_diagnosis.save
        if aki_diagnosis.stage >= 1 and aki_diagnosis.patient.first_aki_diagnosis_at.nil?
          patient.update_attribute(:first_aki_diagnosis_at, aki_diagnosis.created_at)
        end
      end
    end
end
