class Admin::ParameterGroupKindsController < Admin::AdminController
  before_action :set_parameter_group_kind, only: [:show, :edit, :update, :destroy]

  def index
    @parameter_group_kinds = ParameterGroupKind.all
  end

  def show
  end

  def new
    @parameter_group_kind = ParameterGroupKind.new
  end

  def edit
  end

  def create
    @parameter_group_kind = ParameterGroupKind.new parameter_group_kind_params
    if @parameter_group_kind.save
      redirect_to admin_parameter_group_kinds_path, notice: 'Grupo de parámetros creado con éxito.'
    else
      render :new
    end
  end

  def update
    if @parameter_group_kind.update(parameter_group_kind_params)
      redirect_to admin_parameter_group_kinds_path
    else
      render :edit
    end
  end

  def destroy
    if @parameter_group_kind.destroy
      redirect_to admin_parameter_group_kinds_path, notice: 'Grupo de parámetros fue eliminado con éxito.'
    end
  end

  private
    def set_parameter_group_kind
      @parameter_group_kind = ParameterGroupKind.find params[:id]
    end

    def parameter_group_kind_params
      params.require(:parameter_group_kind).permit(
        :institution_id,
        :name,
        parameter_kinds_attributes: [
          :id,
          :name,
          :units,
          :deductible,
          :parameter_type,
          :_destroy
        ]
      )
    end
end
