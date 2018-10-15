json.array!(@epicrises) do |epicrisis|
  json.extract! epicrisis, :id, :patient_id, :aki_diagnosis, :aki_stage, :admission_date, :admission_unit, :discharge_date, :admission_unit, :admission_reason, :dead, :nephrology_assessment, :nephrology_appointment, :ckd, :rrt, :intrahospital_sepsis, :ami, :htn, :copd, :cld, :dm, :esrd, :tel
  json.url epicrisis_url(epicrisis, format: :json)
end
