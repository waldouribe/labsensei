class ReportsController < ApplicationController
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


  	@alerts = @institution.alerts.where(condition)
  	@alert_count = @alerts.order('date ASC').count
  	@alert_count_by_date = @alerts.group('DATE(date)').count
  	day = @from_date

  	while day <= @to_date
  		if @alert_count_by_date[day.strftime("%Y-%m-%d")].blank?
  			@alert_count_by_date[day.strftime("%Y-%m-%d")] = 0
  		end
  		day = day + 1.day
  	end

  	@patients = @institution.patients.joins(:alerts).merge(@alerts).uniq
  	@patients_count = @patients.count
  	@patients_with_birthday = @patients.where("patients.birthday != ?", '')
  	@average_patients_age = Patient.average_age(@patients_with_birthday)

  	@male_patients_count = @patients.where(gender: 'male').count
  	@female_patients_count = @patients.where(gender: 'female').count
  end
end
