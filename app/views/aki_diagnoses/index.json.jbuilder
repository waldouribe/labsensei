json.array!(@aki_diagnoses) do |aki_diagnosis|
  json.extract! aki_diagnosis, :id, :patient_id, :creatinine_test_1_id, :creatinine_test_2_id, :stage, :reason, :increase_net, :increase_percentage
  json.url aki_diagnosis_url(aki_diagnosis, format: :json)
end
