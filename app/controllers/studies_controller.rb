class StudiesController < ApplicationController
  load_and_authorize_resource :institution

  def index
    @patient_count = Patient.where('institution_id = ?', @institution).count
    @aki_patient_count = AkiDiagnosis.joins(:patient).where('stage >= 1 AND institution_id = ?', @institution).count('distinct patient_id')
    @patients_with_diagnosis_count = AkiDiagnosis.joins(:patient).where('institution_id = ?', @institution).count('distinct patient_id')
    @coverage_percent = (1.0*@patients_with_diagnosis_count*100/@patient_count).round(1)
    @aki_patient_percent = (@aki_patient_count*100.0 / @patients_with_diagnosis_count).round(1)
    @male_percent = (1.0*AkiDiagnosis.joins(:patient).where('patients.gender = ? AND institution_id = ?', 'male', @institution).where('stage >= 1').count('distinct patient_id')*100 / @aki_patient_count).round(1)
    @female_percent = (1.0*AkiDiagnosis.joins(:patient).where('patients.gender = ? AND institution_id = ?', 'female', @institution).where('stage >= 1').count('distinct patient_id')*100 / @aki_patient_count).round(1)
    @cretinine_test_count = CreatinineTest.where('institution_id = ?', @institution).count
    @aki_episodes_count = AkiDiagnosis.joins(:patient).where('institution_id = ?', @institution).where('stage >= 1').count
    #avg_birthday = Time.at(AkiDiagnosis.joins(:patient).where('stage >= 1').uniq(:patient_id).average(:birthday)).to_datetime
    #@avg_age = ((Time.now - avg_birthday)/1.year).round
    if @patients_with_diagnosis_count == 0
      render :no_diagnoses
    else
      render :index
    end
  end
end
