require 'rails_helper'

RSpec.describe Trainers::UsersController, type: :controller do

  context "When user was login" do
    before do
      login FactoryBot.create :user, role: :trainer
    end

    describe "GET #index" do
      it "should render index template" do
        get :index
        expect(response).to render_template :index
      end

      it "should render index.js template" do
        get :index, xhr: true
        expect(response).to render_template :index
      end
    end

    describe "GET #new" do
      it "should render new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "POST #create" do
      context "when valid user param" do
        let(:valid_user_param) do
          FactoryBot.attributes_for :user, gender: :male
        end

        it "should redirect to trainers_user_path" do
          post :create, params: {user: valid_user_param}
          expect(response).to redirect_to trainers_user_path assigns(:user)
        end

        it "should increment User by 1" do
          user_valid = FactoryBot.attributes_for :user, gender: :male
          expect{
            post :create, params: {user: user_valid}
          }.to change(User, :count).by 1
        end
      end

      context "when invalid user param" do
        it "should redirect to trainers_user_path" do
          invalid_user_param = FactoryBot.attributes_for :user, name: nil, gender: :male
          post :create, params: {user: invalid_user_param}
          expect(response).to render_template :new
        end
      end
    end

    describe "GET #show" do
      context "when valid param" do
        let!(:user) do
          FactoryBot.create :user
        end

        before do
          get :show, params: {id: user.id}
        end

        it "should have a valid user" do
          expect(assigns(:user).id).to eq user.id
        end

        it "should render show template" do
          expect(response).to render_template :show
        end
      end

      context "when invalid param" do
        before do
          get :show, params: {id: "abc"}
        end

        it "should have a invalid user" do
          expect(assigns(:user)).to eq nil
        end

        it "should have a 404 HTTP" do
          expect(response).to have_http_status 404
        end
      end
    end

    describe "GET #edit" do
      context "when valid param" do
        let!(:user) do
          FactoryBot.create :user
        end

        before do
          get :edit, params: {id: user.id}
        end

        it "should have a valid user" do
          expect(assigns(:user).id).to eq user.id
        end

        it "should render show template" do
          expect(response).to render_template :edit
        end
      end

      context "when invalid param" do
        before do
          get :edit, params: {id: "abc"}
        end

        it "should have a invalid user" do
          expect(assigns(:user)).to eq nil
        end

        it "should have a 404 HTTP" do
          expect(response).to have_http_status 404
        end
      end
    end

    describe "PATCH #update" do
      let!(:user) do
        FactoryBot.create :user
      end

      context "when valid param" do
        before do
          patch :update, params: {id: user.id, user: {name: "Name user edited",
                                                      password: "123456"}}
        end

        it "should correct user name" do
          expect(assigns(:user).name).to eq "Name user edited"
        end

        it "should redirect to trainers_user_path" do
          expect(response).to redirect_to trainers_user_path assigns(:user)
        end
      end

      context "when invalid param" do
        let(:invalid_param) {FactoryBot.attributes_for :user, name: nil, gender: :male}

        before do
          patch :update, params: {id: user, user: invalid_param}
        end

        it "should have a invalid user" do
          expect(assigns(:user).invalid?).to eq true
        end

        it "should render edit template" do
          expect(response).to render_template :edit
        end
      end
    end

    describe "DELETE #destroy" do
      let!(:user) do
        FactoryBot.create :user
      end

      context "when valid param" do
        before do
          delete :destroy, xhr: true, params: {id: user.id}
        end

        it "should destroyed user" do
          expect(assigns(:user).destroyed?).to eq true
        end

        it "should get 200 HTTP" do
          expect(response).to have_http_status 200
        end
      end

      context "when invalid param" do
        before do
          delete :destroy, xhr: true, params: {id: "abc"}
        end

        it "should get 404 HTTP" do
          expect(response).to have_http_status 404
        end
      end

      context "when a failure course destroy" do
        before do
          allow_any_instance_of(User).to receive(:destroy).and_return false
          delete :destroy, xhr: true, params: {id: user.id}
        end

        it "should get content_type" do
          expect(response.content_type).to eq "application/json; charset=utf-8"
        end
      end
    end
  end

  context "When user isn't authorization" do
    it "should have a status 403 HTTP" do
      login FactoryBot.create :user, role: :trainee
      get :index
      expect(response).to have_http_status 403
    end
  end

  context "When user isn't login" do
    it "should have a status 401 HTTP" do
      get :index, params: {locale: :en}
      expect(response).to redirect_to new_user_session_path
    end
  end
end
