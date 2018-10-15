class UsersController < ApplicationController
  load_and_authorize_resource :institution
  load_and_authorize_resource :user

  skip_load_and_authorize_resource :institution, only: [:public_login, :new, :create, :register_message, :edit, :update, :choose_plan, :add_user_to_institution, :create_institution_and_plan]

  skip_load_and_authorize_resource :user, only: [:new, :create, :register_message, :choose_plan, :add_user_to_institution, :create_institution_and_plan]

  before_action :set_user, only: [:show, :edit, :update, :destroy, :register_message, :choose_plan, :add_user_to_institution, :create_institution_and_plan]

  skip_before_action :require_login, only: [:new, :create, :public_login, :register_message, :choose_plan, :add_user_to_institution, :create_institution_and_plan]

  layout 'blank', only: [:new, :create, :register_message, :choose_plan, :add_user_to_institution, :create_institution_and_plan]

  def index
    if @institution
      @users = User.where(institution: @institution).where("role IN (?)", params[:roles]).search(params[:search]).page(params[:page])
    else
      @users = User.all
    end

    @select_roles = []
    User::ROLES.each do |role|
      if current_user.role? :god
        @select_roles << {value: role.to_s, text: I18n.t('users.roles.' + role)}
      elsif role.to_s != 'god'
        @select_roles << {value: role.to_s, text: I18n.t('users.roles.' + role)}
      end
    end

  end

  def show
  end

  def new
    if params['plan_id']
      @plan_id = params['plan_id']
    end
    @user = User.new
    render 'new'
  end

  def public_login
    user = User.find_by email: 'invitado@labsensei.com'
    login user
    redirect_to root_path
  end

  def register_message
  end

  def choose_plan
    @institutions = Institution.all
  end

  def add_user_to_institution
    if @user.update(user_params)
      redirect_to :register_message_users
    else
      render :choose_plan
    end
  end

  def create_institution_and_plan
    active = false
    if params['plan_id'] == '1'
      login @user
      active = true
    end

    @user.role = :admin

    institution = Institution.create(name: 'Institution-'+@user.id.to_s, plan_id: params['plan_id'].to_i, active: active)

    if @user.update(institution: institution)
      render :plan_carousel
    else
      render :choose_plan
    end

  end

  def edit
  end

  def change_password
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html {
          if params['plan_id']
            create_institution_and_plan
          else
            render :choose_plan
          end
        }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { render :edit }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to institution_users_path(@institution) }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:institution_id, :email, :name, :password, :reset_password_token, :authentication_token, :plan_id, :role)
    end
end
