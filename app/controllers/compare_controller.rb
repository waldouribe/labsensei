class CompareController < ApplicationController
  load_and_authorize_resource :institution

  def index
    @patient = Patient.find params[:patient_id]

    if(params[:compare])
      @parameter_kind_1 = params[:compare][:parameter_kind_id_1] || nil
      @parameter_kind_2 = params[:compare][:parameter_kind_id_2] || nil
    else
      @parameter_kind_1 = params[:parameter_kind_id_1] || nil
      @parameter_kind_2 = params[:compared_to] || nil
    end

    @parameter_kinds = ParameterKind.joins(:parameter_group_kind)
      .where('parameter_group_kinds.institution_id' => @institution.id)

    @parameters = [
      Parameter.joins(:parameter_group).where(parameter_kind: @parameter_kind_1).where('parameter_groups.patient_id' => @patient.id).order('parameter_groups.date DESC'),
      Parameter.joins(:parameter_group).where(parameter_kind: @parameter_kind_2).where('parameter_groups.patient_id' => @patient.id).order('parameter_groups.date DESC')
    ]
  end

  def get_comparable_parameters
    parameter_kind_to_compare = ParameterKind.find params[:parameter_kind_id]
    @selected_parameter_id = params[:selected_parameter_id]

    @comparable_parameter_kinds = ParameterKind.joins(:parameter_group_kind)
      .where.not(id: parameter_kind_to_compare.id)
      .where('parameter_group_kinds.institution_id = ? AND units = ?', @institution.id, parameter_kind_to_compare.units )

    render :comparable_parameters, :layout => false
  end
end
