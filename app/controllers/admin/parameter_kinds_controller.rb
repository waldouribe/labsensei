class Admin::ParameterKindsController < Admin::AdminController
  before_action :set_parameter_kind, only: [:show, :edit, :update]
  
  def index
    @parameter_kinds = ParameterGroupKind.all
  end
  
  def show
  end

  def new
    @parameter_kind = ParameterKind.new(parameter_group_kind_id: params[:parameter_group_kind_id])
  end

  def edit
  end

  def create
    @parameter_kind = ParameterKind.new parameter_kind_params
    if @parameter_kind.save
      redirect_to [:admin, @parameter_kind.parameter_group_kind]
    else
      render :new
    end
  end

  def update
  end

  private 
    def set_parameter_kind
      @parameter_kind = ParameterKind.find params[:id]
    end

    def parameter_kind_params      
      params.require(:parameter_kind).permit(:parameter_group_kind_id, :name, :deductible, :parameter_type, :units)
    end
end