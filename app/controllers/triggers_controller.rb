class TriggersController < ApplicationController
  load_and_authorize_resource :institution
  before_action :set_trigger, only: [:show, :edit, :update, :destroy]

  def index
    @triggers = Trigger.all
  end

  def show
  end

  def new
    @trigger = Trigger.new
    load_variables
  end

  def edit
    load_variables
  end

  def create
    @trigger = Trigger.new(trigger_params)
    if @trigger.save
      AlertKindsParameterKind.find_or_create_by(alert_kind: @trigger.alert_kind, parameter_kind: @trigger.parameter_kind)
      redirect_to institution_triggers_path(@institution)
    else
      load_variables
      render :new
    end    
  end

  def update
    if @trigger.update(trigger_params)
      redirect_to institution_trigger_path(@institution, @trigger)
    else
      render :edit
    end
  end

  def destroy
    @trigger.destroy
    redirect_to institutions_triggers_path(@institution)
  end

  private
    def load_variables
      @parameter_kinds = ParameterKind.joins(:parameter_group_kind)
      .where('parameter_group_kinds.institution_id' => @institution.id)
      @alert_kinds = AlertKind.where(institution: @institution)
    end

    def set_trigger
      @trigger = Trigger.find(params[:id])
    end

    def trigger_params
      params.require(:trigger).permit(:parameter_kind_id, :arg0_id, :arg1_id, :alert_kind_id, :kind, :value, :description)
    end
end
