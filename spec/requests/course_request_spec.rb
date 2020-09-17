require 'rails_helper'

RSpec.describe Trainers::CoursesController, type: :controller do
  let!(:course) {FactoryBot.create :course}
  let!(:user) {FactoryBot.create :user, role: :trainer}
  let(:valid_param) {FactoryBot.attributes_for :course}
  let(:invalid_param) {FactoryBot.attributes_for :course, name: nil}

  before do
    login user
    trainer?
  end

  describe "GET #index" do
    let!(:course_two) do
      FactoryBot.create :course, status: :finished, start_date: "14-09-2020",
                        created_at: "14-09-2020",
                        updated_at: "14-09-2020"
    end
    let!(:course_three) do
      FactoryBot.create :course,  status: :postponed, start_date: "15-09-2020",
                        created_at: "15-09-2020"
    end

    before {get :index, params: {page: 1}}

    it "renders the 'index' template" do
      expect(response).to render_template :index
    end

    it "assigns @courses" do
      expect(assigns(:courses).pluck(:id)).to eq [course_three.id, course_two.id, course.id]
    end
  end

  describe "GET #edit" do
    context "when valid param" do
      before {get :edit, params: {id: course.id}}

      it "should have a valid course" do
        expect(assigns(:course).id).to eq course.id
      end

      it "should render edit template" do
        expect(response).to render_template :edit
      end
    end

    context "when invalid param" do
      before {get :edit, params: {id: "abc"}}

      it "should have a invalid course" do
        expect(assigns(:course)).to eq nil
      end

      it "should redirect to trainers_courses_path" do
        expect(response).to redirect_to trainers_courses_path
      end
    end
  end

  describe "PATCH #update" do
    context "when valid params" do
      before {patch :update, params: {id: course.id, course: {name: "Test update"}}}

      it "should correct name" do
        expect(assigns(:course).name).to eq "Test update"
      end

      it "should redirect trainers_course_path" do
        expect(response).to redirect_to trainers_course_path course
      end
    end

    context "when invalid params" do
      before { patch :update, params: {id: course.id, course: invalid_param} }

      it "should a invalid course" do
        expect(assigns(:course).invalid?).to eq true
      end

      it "should render edit template" do
        expect(response).to render_template :edit
      end
    end
  end

  describe "GET #show" do
    context "when valid param" do
      before {get :show, params: {id: course.id}}

      it "should have a valid course" do
        expect(assigns(:course).id).to eq course.id
      end

      it "should render show template" do
        expect(response).to render_template :show
      end
    end

    context "when invalid param" do
      before {get :show, params: {id: "abc"}}

      it "should have a invalid course" do
        expect(assigns(:course)).to eq nil
      end

      it "should redirect to trainers_courses_path" do
        expect(response).to redirect_to trainers_courses_path
      end
    end
  end

  describe "GET #new" do
    let!(:topic) {FactoryBot.create :topic}
    before {get :new}
    it "should render new template" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "when valid params" do
      before {post :create, params: {course: valid_param}}
      let(:valid_param_success) {FactoryBot.attributes_for :course}

      it "should correct course name" do
        expect{
          post :create, params: {course: valid_param_success}
        }.to change(Course, :count).by 1
      end

      it "should redirect to trainers_course_path" do
        expect(response).to redirect_to trainers_course_path assigns(:course)
      end
    end

    context "when invalid params" do
      let!(:topic) {FactoryBot.create :topic}
      before {post :create, params: {course: invalid_param}}

      it "should a invalid course" do
        expect{
          post :create, params: {course: invalid_param}
        }.to change(Course, :count).by 0
      end

      it "should render new template" do
        expect(response).to render_template :new
      end
    end
  end

  describe "DELETE #destroy" do
    context "when valid params" do
      before { delete :destroy, params: {id: course.id} }

      it "should correct name" do
        expect(assigns(:course).destroyed?).to eq true
      end

      it "should redirect to trainers_course_path" do
        expect(response).to redirect_to trainers_courses_path
      end
    end

    context "when invalid params" do
      before {delete :destroy, params: {id: "abc"}}

      it "should a invalid course" do
        expect{subject}.to change(Course, :count).by 0
      end

      it "should redirect to trainers_courses_path" do
        expect(response).to redirect_to trainers_courses_path
      end
    end

    context "when a failure course destroy" do
      before do
        allow_any_instance_of(Course).to receive(:destroy).and_return false
        delete :destroy, params: {id: course.id}
      end

      it "flash error message" do
        expect(flash[:danger]).to eq I18n.t("notice.error")
      end

      it "should redirect to trainers_course_path" do
        expect(response).to redirect_to trainers_courses_path
      end
    end
  end
end
