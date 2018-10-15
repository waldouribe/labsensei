class TestsController < ApplicationController
  skip_before_action :require_login
  def index
    @patient_count = Patient.count
    @aki_patient_count = AkiDiagnosis.joins(:patient).where('stage >= 1').count('distinct patient_id')
    @patients_with_diagnosis_count = AkiDiagnosis.count('distinct patient_id')
    @coverage_percent = (1.0*@patients_with_diagnosis_count*100/@patient_count).round(1)
    @aki_patient_percent = (@aki_patient_count*100.0 / @patients_with_diagnosis_count).round(1)
    @male_percent = (1.0*AkiDiagnosis.joins(:patient).where('patients.gender = ?', 'male').where('stage >= 1').count('distinct patient_id')*100 / @aki_patient_count).round(1)
    @female_percent = (1.0*AkiDiagnosis.joins(:patient).where('patients.gender = ?', 'female').where('stage >= 1').count('distinct patient_id')*100 / @aki_patient_count).round(1)
    @cretinine_test_count = CreatinineTest.count
    @aki_episodes_count = AkiDiagnosis.where('stage >= 1').count
    @aki_episodes_count = AkiDiagnosis.where('stage >= 1').count


    @stage3_patients = Patient.joins(:aki_diagnoses).where('aki_diagnoses.stage' => 3).uniq('patients.id')
    stage3_patient_ids = @stage3_patients.pluck('patients.id')

    @stage2_patients = Patient.joins(:aki_diagnoses).where('aki_diagnoses.stage' => 2).where.not('patients.id' => stage3_patient_ids).uniq('patients.id')
    stage2_patient_ids = @stage2_patients.pluck('patients.id')

    @stage1_patients = Patient.joins(:aki_diagnoses).where('aki_diagnoses.stage' => 1).where.not('patients.id' => stage3_patient_ids+stage2_patient_ids).uniq('patients.id')
    stage1_patient_ids = @stage1_patients.pluck('patients.id')

    @stage0_patients = Patient.joins(:aki_diagnoses).where('aki_diagnoses.stage' => 0).where.not('patients.id' => stage3_patient_ids+stage2_patient_ids+stage1_patient_ids).uniq('patients.id')
    stage0_patient_ids = @stage0_patients.pluck('patients.id')

    diseases = ['dead','nephrology_assessment','nephrology_appointment','ckd','rrt','intrahospital_sepsis','ami','htn','copd','cld','dm','esrd','tel']
    @diseases_info = {}
    diseases.each do |disease|
      stage3_with_disease = Epicrisis.where(disease => true, patient_id: stage3_patient_ids).distinct('patient_id').count
      stage2_with_disease = Epicrisis.where(disease => true, patient_id: stage2_patient_ids).distinct('patient_id').count
      stage1_with_disease = Epicrisis.where(disease => true, patient_id: stage1_patient_ids).distinct('patient_id').count
      stage0_with_disease = Epicrisis.where(disease => true, patient_id: stage0_patient_ids).distinct('patient_id').count
      @diseases_info[disease] = {stage3: stage3_with_disease, stage2: stage2_with_disease, stage1: stage1_with_disease, stage0: stage0_with_disease}
    end

    units = ["Emergency Room", "Elective Surgery", "Other", " "]
    @units_info = {}
    units.each do |unit|
      stage3_from_unit = Epicrisis.where(admission_reason: unit, patient_id: stage3_patient_ids).distinct('patient_id').count
      stage2_from_unit = Epicrisis.where(admission_reason: unit, patient_id: stage2_patient_ids).distinct('patient_id').count
      stage1_from_unit = Epicrisis.where(admission_reason: unit, patient_id: stage1_patient_ids).distinct('patient_id').count
      stage0_from_unit = Epicrisis.where(admission_reason: unit, patient_id: stage0_patient_ids).distinct('patient_id').count
      @units_info[unit] = {stage3: stage3_from_unit, stage2: stage2_from_unit, stage1: stage1_from_unit, stage0: stage0_from_unit}
    end

    @male_aki3 = Patient.where(id: stage3_patient_ids, gender: 'male').count
    @male_aki2 = Patient.where(id: stage2_patient_ids, gender: 'male').count
    @male_aki1 = Patient.where(id: stage1_patient_ids, gender: 'male').count
    @male_aki0 = Patient.where(id: stage0_patient_ids, gender: 'male').count

    @female_aki3 = Patient.where(id: stage3_patient_ids, gender: 'female').count
    @female_aki2 = Patient.where(id: stage2_patient_ids, gender: 'female').count
    @female_aki1 = Patient.where(id: stage1_patient_ids, gender: 'female').count
    @female_aki0 = Patient.where(id: stage0_patient_ids, gender: 'female').count

    days = 0
    epicrises = Epicrisis.where(patient_id: stage3_patient_ids)
    epicrises.each do |epicrisis|
      days += (epicrisis.discharge_date-epicrisis.admission_date).to_i
    end
    @stage3_avg_days = (1.0*days/epicrises.count).round(1)

    days = 0
    epicrises = Epicrisis.where(patient_id: stage2_patient_ids)
    epicrises.each do |epicrisis|
      days += (epicrisis.discharge_date-epicrisis.admission_date).to_i
    end
    @stage2_avg_days = (1.0*days/epicrises.count).round(1)

    days = 0
    epicrises = Epicrisis.where(patient_id: stage1_patient_ids)
    epicrises.each do |epicrisis|
      days += (epicrisis.discharge_date-epicrisis.admission_date).to_i
    end
    @stage1_avg_days = (1.0*days/epicrises.count).round(1)

    days = 0
    epicrises = Epicrisis.where(patient_id: stage0_patient_ids)
    epicrises.each do |epicrisis|
      days += (epicrisis.discharge_date-epicrisis.admission_date).to_i
    end
    @stage0_avg_days = (1.0*days/epicrises.count).round(1)

    



  end
end