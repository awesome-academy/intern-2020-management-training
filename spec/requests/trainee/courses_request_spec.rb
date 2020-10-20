require 'rails_helper'

RSpec.describe Trainee::CoursesController, type: :controller do
  let!(:user) {FactoryBot.create :user, role: :trainee}
  let!(:course) {FactoryBot.create :course}
  let!(:user_course) {FactoryBot.create :user_course, course: course, user: user}
  let!(:subject_1) {FactoryBot.create :subject, name: "timeeee"}
  let!(:course_subject) {FactoryBot.create :course_subject, course: course, subject: subject_1}
  before {login user}

  describe "GET #index" do
    before {get :index, params: {page: 1}}

    it "renders 'index' view" do
      expect(response).to render_template :index
    end

    it "assigns @courses" do
      expect(assigns(:courses).pluck(:id)).to eq [course.id]
    end
  end

  describe "GET #show" do

    before {get :show, params: {id: course.id, page: 1}}

    it "should render 'show' view" do
      expect(response).to render_template :show
    end

    it "should assigns @subjects" do
      expect(assigns(:subjects).pluck(:id)).to eq [subject_1.id]
    end
  end
end
