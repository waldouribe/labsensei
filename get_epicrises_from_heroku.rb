#<Epicrisis id: 3, patient_id: 17, aki_stage: 1, dead: false, nephrology_assessment: false, ckd: false, rrt: true, admission_date: "2013-12-30", discharge_date: "2014-01-24", admission_unit: "ICU", admission_reason: "Emergency Room", nephrology_appointment: false, intrahospital_sepsis: true, created_at: "2014-09-11 17:06:08", updated_at: "2014-09-11 17:06:08", aki_diagnosis: nil>



# t.references :patient, index: true, foreign_key: true
#       t.boolean :aki_diagnosis
#       t.integer :aki_stage
#       t.date :admission_date
#       t.string :admission_unit
#       t.date :discharge_date
#       t.string :admission_unit
#       t.string :admission_reason
#       t.boolean :dead
#       t.boolean :nephrology_assessment
#       t.boolean :nephrology_appointment
#       t.boolean :ckd
#       t.boolean :rrt
#       t.boolean :intrahospital_sepsis
#       t.boolean :ami
#       t.boolean :htn
#       t.boolean :copd
#       t.boolean :cld
#       t.boolean :dm
#       t.boolean :esrd
#       t.boolean :tel

epicrises = []
Epicrisis.all.each do |e|
  if e.aki_diagnosis.present?
    aki_diagnosis = e.aki_diagnosis
  else
    if e.aki_stage.present? and e.aki_stage >= 1
      aki_diagnosis = true
    else
      aki_diagnosis = nil
    end
  end
  object = {
    patient_id: e.patient_id,
    patient_rut: e.patient.rut,
    aki_diagnosis: aki_diagnosis,
    aki_stage: e.aki_stage,
    admission_date_year: e.admission_date.year,
    admission_date_month: e.admission_date.month,
    admission_date_day: e.admission_date.day,
    admission_unit: e.admission_unit,
    discharge_date_year: e.discharge_date.year,
    discharge_date_month: e.discharge_date.month,
    discharge_date_day: e.discharge_date.day,
    admission_reason: e.admission_reason,
    nephrology_assessment: e.nephrology_assessment,
    nephrology_appointment: e.nephrology_appointment,
    ckd: e.ckd,
    rrt: e.rrt,
    dead: e.dead,
    intrahospital_sepsis: e.intrahospital_sepsis
  }
  e.chronic_diseases.each do |cd|
    object[cd.name] = true
  end
  epicrises << object
end

puts "-----------------------------------------------"
puts "-----------------------------------------------"
puts "-----------------------------------------------"
puts "-----------------------------------------------"

epicrises.each do |e|
  puts e
end
