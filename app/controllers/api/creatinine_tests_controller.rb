class Api::CreatinineTestsController < Api::ApiController
  def create
    responses = []

    return render json: std_error(message: 'creatinine_tests required', type: 'invalid_request_error', status: :unprocessable_entity) unless creatinine_tests_params[:creatinine_tests].present?

    creatinine_tests_params[:creatinine_tests].each do |creatinine_test_params|
      patient_params = creatinine_test_params[:patient]

      if patient_params.blank?
        responses << std_error(message: 'patient required', type: 'invalid_request_error', status: :unprocessable_entity)
        next
      end

      patient = Patient.find_by(
        private_id: patient_params[:private_id],
        institution: @current_institution
      )

      if patient.blank?
        patient = Patient.new(patient_params)
        patient.institution = @current_institution
      end

      if patient.save
        creatinine_test_params.delete(:patient)
        creatinine_test = CreatinineTest.new(creatinine_test_params)
        creatinine_test.institution = @current_institution
        creatinine_test.patient = patient

        if creatinine_test.save
          responses << creatinine_test
        else
          responses << model_error(creatinine_test)
        end
      else
        responses << model_error(patient)
      end
    end

    render json: responses
  end

  private

  def model_not_found_error(a_model_name)
    std_error(message: "#{a_model_name} not found", type: 'invalid_request_error', status: :not_found)
  end

  def model_error(an_instance)
    error = an_instance.errors.first
    message = error.join(' ')
    param = error.first.to_s

    std_error(message: message, type: 'invalid_request_error', param: param, status: :unprocessable_entity, the_class: an_instance.class.to_s)
  end

  def std_error(message:, type:, param: nil, status: 500, code: nil, the_class: '')
    json = {error: {}}
    json[:error][:message] = message
    json[:error][:type] = type if type.present?
    json[:error][:param] = param if param.present?
    json[:error][:code] = code if code.present?
    json[:error][:class] = the_class if the_class.present?

    return json
  end

  def creatinine_tests_params
    params.permit(creatinine_tests: [
      [
        :private_id,
        :performed_at,
        :level,
        patient: [
          :private_id,
          :name,
          :email,
          :gender,
          :birthday
        ]
      ]
    ])
  end
end
