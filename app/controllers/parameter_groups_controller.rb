class ParameterGroupsController < ApplicationController
  load_and_authorize_resource :institution
  # TODO: Ver porque no se puede descomentar
  # load_and_authorize_resource through: :institution
  # TODO: Validar institucion?

  def show
  end

  def new
    @patient = Patient.find params[:patient_id]
    @parameter_group_kind = ParameterGroupKind.find params[:parameter_group_kind_id]
    @parameter_group = ParameterGroup.new(patient: @patient, parameter_group_kind: @parameter_group_kind)
  end

  def create
    parameter_group = ParameterGroup.new(parameter_group_params)
    @patient = parameter_group.patient
    if parameter_group.save
      redirect_to institution_patient_parameter_group_kind_path(
        @institution, 
        @patient, 
        parameter_group.parameter_group_kind)
    else
      @parameter_group_kind = parameter_group.parameter_group_kind
      @parameter_group = ParameterGroup.new(patient: @patient, parameter_group_kind: @parameter_group_kind)
      render :new
    end
  end

  private 
    def parameter_group_params
      params.require(:parameter_group).permit(
        :patient_id,
        :parameter_group_kind_id,
        :date,
        parameters_attributes: [:parameter_kind_id, :raw_value]
      )
    end
end