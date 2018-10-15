class TestKindsController < ApplicationController
  before_action :set_test_kind, only: [:show, :edit, :update, :destroy]

  # GET /test_kinds
  # GET /test_kinds.json
  def index
    @test_kinds = TestKind.all
  end

  # GET /test_kinds/1
  # GET /test_kinds/1.json
  def show
  end

  # GET /test_kinds/new
  def new
    @test_kind = TestKind.new
  end

  # GET /test_kinds/1/edit
  def edit
  end

  # POST /test_kinds
  # POST /test_kinds.json
  def create
    @test_kind = TestKind.new(test_kind_params)

    respond_to do |format|
      if @test_kind.save
        format.html { redirect_to @test_kind, notice: 'Test kind was successfully created.' }
        format.json { render :show, status: :created, location: @test_kind }
      else
        format.html { render :new }
        format.json { render json: @test_kind.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /test_kinds/1
  # PATCH/PUT /test_kinds/1.json
  def update
    respond_to do |format|
      if @test_kind.update(test_kind_params)
        format.html { redirect_to @test_kind, notice: 'Test kind was successfully updated.' }
        format.json { render :show, status: :ok, location: @test_kind }
      else
        format.html { render :edit }
        format.json { render json: @test_kind.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /test_kinds/1
  # DELETE /test_kinds/1.json
  def destroy
    @test_kind.destroy
    respond_to do |format|
      format.html { redirect_to test_kinds_url, notice: 'Test kind was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test_kind
      @test_kind = TestKind.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_kind_params
      params.require(:test_kind).permit(:name)
    end
end
