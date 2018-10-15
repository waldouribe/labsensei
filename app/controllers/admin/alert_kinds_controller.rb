class Admin::AlertKindsController < Admin::AdminController
  before_action :set_alert_kind, only: [:show, :edit, :update]
  
  def index
    @alert_kinds = AlertKind.all
  end
  
  def show
  end

  def new
    @alert_kind = AlertKind.new
  end

  def edit
  end

  def create
    @alert_kind = AlertKind.new alert_kind_params
    if @alert_kind.save
      redirect_to admin_alert_kinds_path
    else
      render :new
    end
  end

  def update
  end

  private 
    def set_alert_kind
      @alert_kind = AlertKind.find params[:id]
    end

    def alert_kind_params
      params.require(:alert_kind).permit(:institution_id, :name, :severity, :description)
    end
end