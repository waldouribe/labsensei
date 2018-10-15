class AkiDiagnosesController < ApplicationController
  before_action :set_aki_diagnosis, only: [:show, :edit, :update, :destroy]

  # GET /aki_diagnoses
  # GET /aki_diagnoses.json
  def index
    set_dates

    respond_to do |format|
      format.html do
        @aki_diagnoses = AkiDiagnosis.where("stage >= 1").where("discovered_at BETWEEN ? AND ?", @from_date, @to_date).order("patient_id ASC").page(params[:page]).per_page(10)
        render :index
      end
      format.xlsx do
        @aki_diagnoses = AkiDiagnosis.where("stage >= 1").where("discovered_at BETWEEN ? AND ?", @from_date, @to_date).order("discovered_at DESC")
      end
    end
  end

  # GET /aki_diagnoses/1
  # GET /aki_diagnoses/1.json
  def show
  end

  # GET /aki_diagnoses/new
  def new
    @aki_diagnosis = AkiDiagnosis.new
  end

  # GET /aki_diagnoses/1/edit
  def edit
  end

  # POST /aki_diagnoses
  # POST /aki_diagnoses.json
  def create
    @aki_diagnosis = AkiDiagnosis.new(aki_diagnosis_params)

    respond_to do |format|
      if @aki_diagnosis.save
        format.html { redirect_to @aki_diagnosis, notice: 'Diagnosis aki was successfully created.' }
        format.json { render :show, status: :created, location: @aki_diagnosis }
      else
        format.html { render :new }
        format.json { render json: @aki_diagnosis.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /aki_diagnoses/1
  # PATCH/PUT /aki_diagnoses/1.json
  def update
    respond_to do |format|
      if @aki_diagnosis.update(aki_diagnosis_params)
        format.html { redirect_to @aki_diagnosis, notice: 'Diagnosis aki was successfully updated.' }
        format.json { render :show, status: :ok, location: @aki_diagnosis }
      else
        format.html { render :edit }
        format.json { render json: @aki_diagnosis.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /aki_diagnoses/1
  # DELETE /aki_diagnoses/1.json
  def destroy
    @aki_diagnosis.destroy
    respond_to do |format|
      format.html { redirect_to aki_diagnoses_url, notice: 'Diagnosis aki was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_aki_diagnosis
      @aki_diagnosis = AkiDiagnosis.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def aki_diagnosis_params
      params.require(:aki_diagnosis).permit(:patient_id, :creatinine_test_1_id, :creatinine_test_2_id, :stage, :reason, :increase_net, :increase_percentage)
    end

    def set_dates
      @from_date =  Date.today - 1.month
      @to_date = Date.today

      if params[:filter].present?
        @from_date = Date.new(params[:filter]['from_date(1i)'].to_i, params[:filter]['from_date(2i)'].to_i, params[:filter]['from_date(3i)'].to_i)
        @to_date = Date.new(params[:filter]['to_date(1i)'].to_i, params[:filter]['to_date(2i)'].to_i, params[:filter]['to_date(3i)'].to_i)
      end

      @from_date = @from_date.beginning_of_day
      @to_date = @to_date.end_of_day
    end
end
