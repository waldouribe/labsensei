class AkiDiagnosesController < ApplicationController
  before_action :set_aki_diagnosis, only: [:show, :edit, :update, :destroy]

  # GET /aki_diagnoses
  # GET /aki_diagnoses.json
  def index
    respond_to do |format|
      format.html do
        @aki_diagnoses = AkiDiagnosis.where("stage >= 1").order("patient_id ASC").page(params[:page]).per_page(10)
        if @aki_diagnoses.any?
          render :index
        else
          render :no_diagnoses
        end
      end
      format.xlsx do
        @aki_diagnoses = AkiDiagnosis.where("stage >= 1").order("discovered_at DESC")
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
end
