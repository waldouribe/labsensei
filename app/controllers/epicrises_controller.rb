class EpicrisesController < ApplicationController
  before_action :set_epicrisis, only: [:show, :edit, :update, :destroy]

  # GET /epicrises
  # GET /epicrises.json
  def index
    @epicrises = Epicrisis.all
    @epicrises = @epicrises.page(params[:page])
  end

  # GET /epicrises/1
  # GET /epicrises/1.json
  def show
  end

  # GET /epicrises/new
  def new
    @epicrisis = Epicrisis.new
  end

  # GET /epicrises/1/edit
  def edit
  end

  # POST /epicrises
  # POST /epicrises.json
  def create
    @epicrisis = Epicrisis.new(epicrisis_params)

    respond_to do |format|
      if @epicrisis.save
        format.html { redirect_to @epicrisis, notice: 'Epicrisis was successfully created.' }
        format.json { render :show, status: :created, location: @epicrisis }
      else
        format.html { render :new }
        format.json { render json: @epicrisis.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /epicrises/1
  # PATCH/PUT /epicrises/1.json
  def update
    respond_to do |format|
      if @epicrisis.update(epicrisis_params)
        format.html { redirect_to @epicrisis, notice: 'Epicrisis was successfully updated.' }
        format.json { render :show, status: :ok, location: @epicrisis }
      else
        format.html { render :edit }
        format.json { render json: @epicrisis.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /epicrises/1
  # DELETE /epicrises/1.json
  def destroy
    @epicrisis.destroy
    respond_to do |format|
      format.html { redirect_to epicrises_url, notice: 'Epicrisis was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_epicrisis
      @epicrisis = Epicrisis.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def epicrisis_params
      params.require(:epicrisis).permit(:patient_id, :aki_diagnosis, :aki_stage, :admission_date, :admission_unit, :discharge_date, :admission_unit, :admission_reason, :dead, :nephrology_assessment, :nephrology_appointment, :ckd, :rrt, :intrahospital_sepsis, :ami, :htn, :copd, :cld, :dm, :esrd, :tel)
    end
end
