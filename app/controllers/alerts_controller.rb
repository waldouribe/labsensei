class AlertsController < ApplicationController
  load_and_authorize_resource :institution

  def index
    @alert_kinds = @institution.alert_kinds
    @from_date =  Date.today - 1.year
    @to_date = Date.today
    @alert_kind_id = ''

    if params[:alert].present?
      @from_date = Date.new(params[:alert]['from_date(1i)'].to_i, params[:alert]['from_date(2i)'].to_i, params[:alert]['from_date(3i)'].to_i)      
      @to_date = Date.new(params[:alert]['to_date(1i)'].to_i, params[:alert]['to_date(2i)'].to_i, params[:alert]['to_date(3i)'].to_i)
      @alert_kind_id = params[:alert][:alert_kind_id] || @alert_kind_id
    end
    
    @from_date = @from_date.beginning_of_day
    @to_date = @to_date.end_of_day

    condition = "date BETWEEN '#{@from_date}' AND '#{@to_date}' "
    condition += "AND alert_kind_id = #{@alert_kind_id}" if @alert_kind_id.present?

    @alerts = @institution.alerts.where(condition).paginate(page: params[:page], per_page: 20)
    .paginate(page: params[:page], per_page: 20)
  end
end
