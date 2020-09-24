require "rails_helper"

RSpec.describe Trainers::SubjectsController, type: :controller do
  let!(:user) {FactoryBot.create :user, role: :trainer}
  let!(:subject_1) {FactoryBot.create :subject, name: "unit test"}
  let!(:subject_2) {FactoryBot.create :subject, name: "php advance"}
  let!(:subject_3) {FactoryBot.create :subject, name: "git basic"}
  let!(:topic_1) {FactoryBot.create :topic, name: "ror 2020"}
  let!(:topic_subject) {FactoryBot.create :topic_subject, subject: subject_1, topic: topic_1}
  let(:valid_params) do
    FactoryBot.attributes_for(:subject,
      tasks_attributes: [FactoryBot.attributes_for(:task)]
    )
  end
  let(:invalid_params) {FactoryBot.attributes_for :subject, name: nil}

  before {login user}

  describe "GET #index" do
    context "with valid param: ids to search" do
      before {get :index, params: {ids: [subject_1.id], topic: [topic_1.id], query: "git"}}
      it "assigns the requested subjects as @subjects" do
        expect(assigns(:subjects).pluck(:id)).to eq [subject_3.id]
      end
    end

    before {get :index, params: {ids: nil}}
    context "with invalid param: ids is blank" do
      it "assigns the all subjects as @subjects" do
        expect(assigns(:subjects).size).to eq Subject.count
      end
    end
  end

  describe "GET #show" do
    context "with valid param" do
      before {get :show, params: {id: subject_1.id}, format: :js}

      it "render modal detail" do
        expect(response).to render_template :show
      end
    end

    context "with invalid param" do
      before {get :show, params: {id: 100}, format: :json}

      it "response 200 with error: true" do
        expect(JSON.parse(response.body)["err"]).to eq true
      end
    end
  end

  describe "GET #new" do
    before {get :new}

    it "assigns a new Subject to @subject" do
      expect(assigns(:subject)).to be_a_new Subject
    end

    it "render the new view" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with invalid attributes" do
      before do
        post :create, params: {subject: invalid_params}
      end

      it "create a new subject fail" do
        expect{
          post :create, params: {subject: invalid_params}
        }.to change(Subject, :count).by(0)
      end

      it "render template subject" do
        expect(response).to render_template :new
      end

      it "create a new event fail" do
        expect(flash[:error]).to match I18n.t("flash.subject.error")
      end
    end

    context "with valid attributes" do
      before do
        post :create, params: {subject: valid_params}
      end
      let!(:valid_params_success) do
        FactoryBot.attributes_for(:subject,
          tasks_attributes: [FactoryBot.attributes_for(:task)]
        )
      end

      it "create a new subject success" do
        expect{
          post :create, params: {subject: valid_params_success}
        }.to change(Subject, :count).by(1)
      end

      it "should redirect to trainers_subjects_path" do
        expect(response).to redirect_to trainers_subjects_path
      end

      it "show flash success" do
        expect(flash["success"]).to match I18n.t("flash.subject.success")
      end
    end
  end

  describe "GET #edit" do
    context "with valid subject" do
      it "find subject & render view edit template" do
        get :edit, params: {id: subject_1.id}, format: :js
        expect(response).to render_template :edit
      end
    end

    context "with invalid subject" do
      it "not find subject & redirect to trainers_subjects_path" do
        get :edit, params: {id: 100}, format: :json
        expect(JSON.parse(response.body)["err"]).to eq true
      end
    end
  end

  describe "PATCH #update" do
    context "when valid params" do
      before {patch :update, params: {id: subject_1.id, subject: {name: "Test update"}}}

      it "should correct name" do
        expect(assigns(:subject).name).to eq "Test update"
      end

      it "should redirect trainers_subjects_path" do
        expect(response).to redirect_to trainers_subjects_path
      end

      it "show flash success" do
        expect(flash[:success]).to match I18n.t("flash.subject.success")
      end
    end

    context "when invalid params" do
      before {patch :update, params: {id: subject_1.id, subject: invalid_params}, format: :js}

      it "should a invalid subject" do
        expect(assigns(:subject).invalid?).to eq true
      end

      it "should render edit template" do
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    context "with valid subject" do
      let!(:subject_destroy) {FactoryBot.create :subject, name: "test nuwa"}

      before {delete :destroy, params: {id: subject_1.id}, format: :json}

      it "delete success" do
        expect{
          delete :destroy, params: {id: subject_destroy.id}
        }.to change(Subject, :count).by(-1)
      end

      it "response 200 with json success: true" do
        expect(JSON.parse(response.body)["success"]["id"]).to eq subject_1.id
      end
    end

    context "cant delete because of belonging to active course" do
      let!(:course_1) {FactoryBot.create :course}
      let!(:course_subject_1) {FactoryBot.create :course_subject, course: course_1, subject: subject_1, status: "inprogress"}
      before {delete :destroy, params: {id: subject_1.id}, format: :json}

      it "delete failed" do
        expect{
          delete :destroy, params: {id: subject_1.id}
        }.to change(Subject, :count).by(0)
      end

      it "response 200 with json active_course: true" do
        expect(JSON.parse(response.body)["active_course"]).to eq true
      end
    end

    context "delete failed" do
      before do
        allow_any_instance_of(Subject).to receive(:destroy).and_return(false)
      end

      it "delete fail" do
        expect{delete :destroy, params: {id: subject_1.id}, format: :json}.to change(Subject, :count).by(0)
      end
    end
  end
end
