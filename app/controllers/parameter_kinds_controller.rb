class ParameterKindsController < ApplicationController
  load_and_authorize_resource :institution

  def show
    @patient = Patient.find params[:patient_id]
    @parameter_group_kinds = ParameterGroupKind.where(institution: @institution)
    @parameter_group_kind = ParameterGroupKind.find params[:parameter_group_kind_id]
    @parameter_kind = ParameterKind.find params[:id]
    @alerts = @parameter_kind.alerts.where(patient: @patient)
    @parameters = Parameter.joins(:parameter_group).where(parameter_kind: @parameter_kind).where('parameter_groups.patient_id' => @patient.id).order('parameter_groups.date DESC')
  end
end
