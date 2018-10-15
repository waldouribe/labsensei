require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe TestKindsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # TestKind. As you add validations to TestKind, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TestKindsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all test_kinds as @test_kinds" do
      test_kind = TestKind.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:test_kinds)).to eq([test_kind])
    end
  end

  describe "GET #show" do
    it "assigns the requested test_kind as @test_kind" do
      test_kind = TestKind.create! valid_attributes
      get :show, {:id => test_kind.to_param}, valid_session
      expect(assigns(:test_kind)).to eq(test_kind)
    end
  end

  describe "GET #new" do
    it "assigns a new test_kind as @test_kind" do
      get :new, {}, valid_session
      expect(assigns(:test_kind)).to be_a_new(TestKind)
    end
  end

  describe "GET #edit" do
    it "assigns the requested test_kind as @test_kind" do
      test_kind = TestKind.create! valid_attributes
      get :edit, {:id => test_kind.to_param}, valid_session
      expect(assigns(:test_kind)).to eq(test_kind)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new TestKind" do
        expect {
          post :create, {:test_kind => valid_attributes}, valid_session
        }.to change(TestKind, :count).by(1)
      end

      it "assigns a newly created test_kind as @test_kind" do
        post :create, {:test_kind => valid_attributes}, valid_session
        expect(assigns(:test_kind)).to be_a(TestKind)
        expect(assigns(:test_kind)).to be_persisted
      end

      it "redirects to the created test_kind" do
        post :create, {:test_kind => valid_attributes}, valid_session
        expect(response).to redirect_to(TestKind.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved test_kind as @test_kind" do
        post :create, {:test_kind => invalid_attributes}, valid_session
        expect(assigns(:test_kind)).to be_a_new(TestKind)
      end

      it "re-renders the 'new' template" do
        post :create, {:test_kind => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested test_kind" do
        test_kind = TestKind.create! valid_attributes
        put :update, {:id => test_kind.to_param, :test_kind => new_attributes}, valid_session
        test_kind.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested test_kind as @test_kind" do
        test_kind = TestKind.create! valid_attributes
        put :update, {:id => test_kind.to_param, :test_kind => valid_attributes}, valid_session
        expect(assigns(:test_kind)).to eq(test_kind)
      end

      it "redirects to the test_kind" do
        test_kind = TestKind.create! valid_attributes
        put :update, {:id => test_kind.to_param, :test_kind => valid_attributes}, valid_session
        expect(response).to redirect_to(test_kind)
      end
    end

    context "with invalid params" do
      it "assigns the test_kind as @test_kind" do
        test_kind = TestKind.create! valid_attributes
        put :update, {:id => test_kind.to_param, :test_kind => invalid_attributes}, valid_session
        expect(assigns(:test_kind)).to eq(test_kind)
      end

      it "re-renders the 'edit' template" do
        test_kind = TestKind.create! valid_attributes
        put :update, {:id => test_kind.to_param, :test_kind => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested test_kind" do
      test_kind = TestKind.create! valid_attributes
      expect {
        delete :destroy, {:id => test_kind.to_param}, valid_session
      }.to change(TestKind, :count).by(-1)
    end

    it "redirects to the test_kinds list" do
      test_kind = TestKind.create! valid_attributes
      delete :destroy, {:id => test_kind.to_param}, valid_session
      expect(response).to redirect_to(test_kinds_url)
    end
  end

end
