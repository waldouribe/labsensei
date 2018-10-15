class ParameterGroupKindsController < ApplicationController
  load_and_authorize_resource :institution
  load_and_authorize_resource through: :institution

  def show
    @patient = Patient.find params[:patient_id]
    @parameter_group_kind = ParameterGroupKind.find params[:id]
    @parameter_kind = @parameter_group_kind.parameter_kinds.first
    redirect_to institution_patient_parameter_group_kind_parameter_kind_path(@institution, @patient, @parameter_group_kind, @parameter_kind)
  end
end