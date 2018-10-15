json.array!(@creatinine_tests) do |creatinine_test|
  json.extract! creatinine_test, :id, :private_id, :patient_id, :level, :performed_at
  json.url creatinine_test_url(creatinine_test, format: :json)
end
