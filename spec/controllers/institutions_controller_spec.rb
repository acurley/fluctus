require 'spec_helper'

describe InstitutionsController do
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # InstitutionsController. Be sure to keep this updated too.
  # let(:valid_session) { {} }

  before(:all) do
    @institution = FactoryGirl.create(:fake_university)
    @user = FactoryGirl.create(:user)
  end

  after(:all) do
    @user.delete; @institution.delete; Role.destroy_all
  end

  describe "GET #index" do
    describe "for admin users" do 
      before do 
        @user.role_ids = [Role.where(name: 'admin').first.id]
        sign_in @user
      end

      after do
        sign_out @user
        @user.role_ids = []
      end

      it "responds successfully with an HTTP 200 status code" do
        get :index
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the index template" do
        get :index
        expect(response).to render_template("index")
      end

      it "assigns all institutions as @institutions" do
        get :index
        assigns(:institutions).should eq([@institution])
      end
    end
  end

  describe "GET #show" do
    describe "for admin user" do 
      before do 
        @user.role_ids = [Role.where(name: 'admin').first.id]
        sign_in @user
      end

      after do
        @user.role_ids = []
      end

      it "responds successfully with an HTTP 200 status code" do
        get :show, id: @institution.to_param
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the index template" do
        get :show, id: @institution.to_param
        expect(response).to render_template("show")
      end

      it "assigns the requested institution as @institution" do
        get :show, id: @institution.to_param
        assigns(:institution).should eq(@institution)
      end
    end

    describe "for institutional_admin user" do 
      before do 
        @user.role_ids = [Role.where(name: 'institutional_admin').first.id]
        sign_in @user
      end

      after do
        @user.role_ids = []
      end

      it "responds successfully with an HTTP 200 status code" do
        get :show, id: @institution.to_param
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the index template" do
        get :show, id: @institution.to_param
        expect(response).to render_template("show")
      end

      it "assigns the requested institution as @institution" do
        get :show, id: @institution.to_param
        assigns(:institution).should eq(@institution)
      end
    end

    describe "for institutional_user user" do 
      before do 
        @user.role_ids = [Role.where(name: 'institutional_user').first.id]
        sign_in @user
      end

      after do
        @user.role_ids = []
      end

      it "responds successfully with an HTTP 200 status code" do
        get :show, id: @institution.to_param
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the index template" do
        get :show, id: @institution.to_param
        expect(response).to render_template("show")
      end

      it "assigns the requested institution as @institution" do
        get :show, id: @institution.to_param
        assigns(:institution).should eq(@institution)
      end
    end
  end

  # describe "GET new" do
  #   it "assigns a new institution as @institution" do
  #     get :new, {}, valid_session
  #     assigns(:institution).should be_a_new(Institution)
  #   end
  # end

  # describe "GET edit" do
  #   it "assigns the requested institution as @institution" do
  #     institution = Institution.create! valid_attributes
  #     get :edit, {:id => institution.to_param}, valid_session
  #     assigns(:institution).should eq(institution)
  #   end
  # end

  # describe "POST create" do
  #   describe "with valid params" do
  #     it "creates a new Institution" do
  #       expect {
  #         post :create, {:institution => valid_attributes}, valid_session
  #       }.to change(Institution, :count).by(1)
  #     end

  #     it "assigns a newly created institution as @institution" do
  #       post :create, {:institution => valid_attributes}, valid_session
  #       assigns(:institution).should be_a(Institution)
  #       assigns(:institution).should be_persisted
  #     end

  #     it "redirects to the created institution" do
  #       post :create, {:institution => valid_attributes}, valid_session
  #       response.should redirect_to(Institution.last)
  #     end
  #   end

  #   describe "with invalid params" do
  #     it "assigns a newly created but unsaved institution as @institution" do
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Institution.any_instance.stub(:save).and_return(false)
  #       post :create, {:institution => { "name" => "invalid value" }}, valid_session
  #       assigns(:institution).should be_a_new(Institution)
  #     end

  #     it "re-renders the 'new' template" do
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Institution.any_instance.stub(:save).and_return(false)
  #       post :create, {:institution => { "name" => "invalid value" }}, valid_session
  #       response.should render_template("new")
  #     end
  #   end
  # end

  # describe "PUT update" do
  #   describe "with valid params" do
  #     it "updates the requested institution" do
  #       institution = Institution.create! valid_attributes
  #       # Assuming there are no other institutions in the database, this
  #       # specifies that the Institution created on the previous line
  #       # receives the :update_attributes message with whatever params are
  #       # submitted in the request.
  #       Institution.any_instance.should_receive(:update).with({ "name" => "MyString" })
  #       put :update, {:id => institution.to_param, :institution => { "name" => "MyString" }}, valid_session
  #     end

  #     it "assigns the requested institution as @institution" do
  #       institution = Institution.create! valid_attributes
  #       put :update, {:id => institution.to_param, :institution => valid_attributes}, valid_session
  #       assigns(:institution).should eq(institution)
  #     end

  #     it "redirects to the institution" do
  #       institution = Institution.create! valid_attributes
  #       put :update, {:id => institution.to_param, :institution => valid_attributes}, valid_session
  #       response.should redirect_to(institution)
  #     end
  #   end

  #   describe "with invalid params" do
  #     it "assigns the institution as @institution" do
  #       institution = Institution.create! valid_attributes
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Institution.any_instance.stub(:save).and_return(false)
  #       put :update, {:id => institution.to_param, :institution => { "name" => "invalid value" }}, valid_session
  #       assigns(:institution).should eq(institution)
  #     end

  #     it "re-renders the 'edit' template" do
  #       institution = Institution.create! valid_attributes
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Institution.any_instance.stub(:save).and_return(false)
  #       put :update, {:id => institution.to_param, :institution => { "name" => "invalid value" }}, valid_session
  #       response.should render_template("edit")
  #     end
  #   end
  # end

  # describe "DELETE destroy" do
  #   it "destroys the requested institution" do
  #     institution = Institution.create! valid_attributes
  #     expect {
  #       delete :destroy, {:id => institution.to_param}, valid_session
  #     }.to change(Institution, :count).by(-1)
  #   end

  #   it "redirects to the institutions list" do
  #     institution = Institution.create! valid_attributes
  #     delete :destroy, {:id => institution.to_param}, valid_session
  #     response.should redirect_to(institutions_url)
  #   end
  # end

end
