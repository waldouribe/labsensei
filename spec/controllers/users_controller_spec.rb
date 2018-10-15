require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:institution) { create(:institution) }
  let(:valid_attributes) {
    { institution: institution, name: 'John Doe', email: 'user@email.com', password: 'PassPass1234', password_confirmation: 'PassPass1234' }
  }

  let(:invalid_email) {
    { name: 'John Doe', email: 'useremail.com', password: 'PassPass1234', password_confirmation: 'PassPass1234' }
  }

  let(:invalid_password) {
    { name: 'John Doe', email: 'useremail.com', password: 'PassPass124', password_confirmation: 'PassPass1234' }
  }

  describe "POST #create" do
    context "with valid params" do
      it "creates a new User" do
        expect {
          post :create, { :user => valid_attributes }
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :create, {:user => valid_attributes}, valid_session
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end

      it "redirects to the created deleteme" do
        post :create, {:deleteme => valid_attributes}, valid_session
        expect(response).to redirect_to(Deleteme.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        post :create, {:user => invalid_attributes}, valid_session
        expect(assigns(:user)).to be_a_new(User)
      end

      it "re-renders the 'new' template" do
        post :create, {:user => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end 
end