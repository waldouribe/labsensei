class CreatinineTestsController < ApplicationController
  before_action :set_creatinine_test, only: [:show, :edit, :update, :destroy]

  # GET /creatinine_tests
  # GET /creatinine_tests.json
  def index
    @creatinine_tests = CreatinineTest.all
  end

  # GET /creatinine_tests/1
  # GET /creatinine_tests/1.json
  def show
  end

  # GET /creatinine_tests/new
  def new
    @creatinine_test = CreatinineTest.new
  end

  # GET /creatinine_tests/1/edit
  def edit
  end

  # POST /creatinine_tests
  # POST /creatinine_tests.json
  def create
    @creatinine_test = CreatinineTest.new(creatinine_test_params)

    respond_to do |format|
      if @creatinine_test.save
        format.html { redirect_to @creatinine_test, notice: 'Test creatinine was successfully created.' }
        format.json { render :show, status: :created, location: @creatinine_test }
      else
        format.html { render :new }
        format.json { render json: @creatinine_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /creatinine_tests/1
  # PATCH/PUT /creatinine_tests/1.json
  def update
    respond_to do |format|
      if @creatinine_test.update(creatinine_test_params)
        format.html { redirect_to @creatinine_test, notice: 'Test creatinine was successfully updated.' }
        format.json { render :show, status: :ok, location: @creatinine_test }
      else
        format.html { render :edit }
        format.json { render json: @creatinine_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /creatinine_tests/1
  # DELETE /creatinine_tests/1.json
  def destroy
    @creatinine_test.destroy
    respond_to do |format|
      format.html { redirect_to creatinine_tests_url, notice: 'Test creatinine was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_creatinine_test
      @creatinine_test = CreatinineTest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def creatinine_test_params
      params.require(:creatinine_test).permit(:private_id, :patient_id, :level, :performed_at)
    end
end
