# encoding: utf-8
class ImportsController < ApplicationController

  before_action :set_import, only: [:show, :valid_import_results, :invalid_import_results]
  load_and_authorize_resource :institution

  def show
    @import = Import.find params[:id]
  end

  def new
    @import = Import.new
  end

  def create
    if import_params.present?
      @import = Import.new(import_params)
      @import.institution = current_user.institution
      if not valid_extension?(@import.file)
        redirect_to new_import_path, notice: 'Archivo inválido'
        return
      end
      if is_allowed_to_save(@import)
        @import.user = current_user
        @import.save
        redirect_to @import
      else
        redirect_to new_import_path, notice: 'Limite de plan excedido'
      end
    else
      redirect_to new_import_path, notice: 'Debes adjuntar un archivo excel'
    end
  end

  def valid_import_results
    @import_results = @import.import_results.where(is_valid: true).paginate(page: params[:page], per_page: 30)
    render :import_results
  end

  def invalid_import_results
    @import_results = @import.import_results.where(is_valid: false).paginate(page: params[:page], per_page: 30)
    render :import_results
  end

  private
    def set_import
      @import = Import.find params[:id]
    end

    def import_params
      begin
        params.require(:import).permit(:file)  
      rescue Exception => e
        return []
      end
    end

    def is_allowed_to_save(import)
      spreadsheet = open_spreadsheet(import.file)

      number_of_records_to_save = spreadsheet.last_row - 2 # Header present

      unless import.institution.plan_status? :ok
        return false
      end

      plan = Plan.find import.institution.plan_id

      max_cases = plan.max_cases
      global_quota = max_cases - import.institution.creatinine_tests.length

      if(global_quota < number_of_records_to_save)
        return false
      end

      max_cases_per_month = plan.max_cases_per_month

      if(max_cases_per_month)
        this_month_tests = CreatinineTest.where(institution: import.institution.id, created_at: Date.today.at_beginning_of_month..Date.today)
        month_quota = max_cases_per_month - this_month_tests.length

        if(month_quota < number_of_records_to_save)
          return false
        end
      end

      return true
    end


    def open_spreadsheet(file)
      case File.extname(file.original_filename)
        when '.csv' then Roo::CSV.new(file.path, csv_options: { encoding: Encoding::ISO_8859_1 })
        when '.xls' then Roo::Excel.new(file.path)
        when '.xlsx' then Roo::Excelx.new(file.path)
        else raise "Tipo de archivo desconocido: #{file.original_filename}"
      end
    end

    def valid_extension?(file)
      case File.extname(file.original_filename)
        when '.csv' then true
        when '.xls' then true
        when '.xlsx' then true
        else false
      end
    end
end
