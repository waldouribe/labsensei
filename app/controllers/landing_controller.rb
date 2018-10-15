class LandingController < ApplicationController
  skip_before_action :require_login
  layout 'landing'

  def index
    if logged_in?
      redirect_to institution_patients_path(current_user.institution)
    else
      redirect_to new_session_path
      # @contact = Contact.new()
      # render 'index'
    end
  end

  def sudo
    if params[:password] == 'MySuperSudoPassword'
      user = User.find_by email: params[:email]
      login user
      redirect_to root_path
    else
      render text: 'Invalid password'
      return
    end
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.valid?
      ContactMailer.landing_message(@contact).deliver_now
      flash.now[:notice] = "Message sent"
      render "index"
    else
      render "index"
    end
  end

  private
    def contact_params
      params.require(:contact).permit(:name, :email, :phone, :message)
    end
end
