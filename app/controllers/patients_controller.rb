class PatientsController < ApplicationController
  load_and_authorize_resource :institution
  load_and_authorize_resource through: :institution

  def index
    @patients = Patient.where(institution: @institution).order('name ASC').page(params[:page])
    @patients_count = Patient.count
    @male_patients_count = Patient.where(gender: 'male').count
    @female_patients_count = Patient.where(gender: 'female').count
  end

  def search
    @patients = Patient.where("institution_id = ? AND lower(name) LIKE ? OR lower(private_id) LIKE ?", @institution.id, "%#{params[:search].downcase}%", "%#{params[:search].downcase}%")
    @patients_count = @patients.count
    @male_patients_count = @patients.where(gender: 'male').count
    @female_patients_count = @patients.where(gender: 'female').count
    @patients = @patients.page(params[:page])
    render :index
  end

  def show
    @parameter_group_kinds = ParameterGroupKind.where institution: @institution

    if @parameter_group_kinds.blank?
      @can_show_data = false
      render :show
    elsif @parameter_group_kinds.first.parameter_kinds.blank?
      @can_show_data = false
      render :show
    else
      @can_show_data = true

      parameter_group_kind_id = params[:parameter_group_kind_id] || @parameter_group_kinds.first.id
      @parameter_group_kind = ParameterGroupKind.find_by id: parameter_group_kind_id, institution: @institution

      parameter_kind_id = params[:parameter_kind_id] || @parameter_group_kind.parameter_kinds.first.id
      @parameter_kind = @parameter_group_kind.parameter_kinds.find parameter_kind_id

      @parameters = Parameter.joins(:parameter_group)
        .where(parameter_kind: @parameter_kind)
        .where('parameter_groups.patient_id' => @patient.id)
        .order('parameter_groups.date DESC')
      @alerts = @parameter_kind.alerts.where(patient: @patient)

      render :show
    end
  end

  def new
    @patient = Patient.new
  end

  def new_parameter_group
    @parameter_group_kind = ParameterGroupKind.find params[:parameter_group_kind_id]
    @parameter_group = ParameterGroup.new
  end

  def add_parameter_group

  end

  def edit
  end

  def create
    @patient = Patient.new(patient_params)
    @patient.institution = @institution


    if @patient.save
      redirect_to institution_patients_path(@institution)
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to @patient, notice: 'Patient was successfully updated.' }
        format.json { render :show, status: :ok, location: @patient }
      else
        format.html { render :edit }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @patient.destroy
    respond_to do |format|
      format.html { redirect_to patients_url, notice: 'Patient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def patient_params
      params.require(:patient).permit(:private_id, :name, :email, :gender, :birthday)
    end
end
