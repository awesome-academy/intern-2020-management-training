require "rails_helper"

RSpec.describe Trainers::TopicsController, type: :controller do
  let!(:user) {FactoryBot.create :user, role: :trainer}
  let!(:topic_1) {FactoryBot.create :topic}
  let!(:subject_1) {FactoryBot.create :subject}
  let!(:topic_subject_1) {FactoryBot.create :topic_subject, topic: topic_1, subject: subject_1}

  before {login user}

  describe "GET #index" do
    context "with valid param" do
      before {get :index, params: {id: topic_1.id}, format: :js}

      it "should respond js" do
        expect(response).to render_template :index
      end

      it "should assigns @subjects" do
        expect(assigns(:subjects).pluck(:id)).to eq [subject_1.id]
      end
    end
  end

  context "with invalid param" do
    before {get :index, params: {id: nil}, format: :js}

    it "should respond js" do
      expect(response).to render_template :index
    end

    it "should assigns subject of first topic for @subjects" do
      expect(assigns(:subjects).pluck(:id)).to eq Topic.first.subjects.pluck(:id)
    end
  end
end
