require "rails_helper"

RSpec.describe Trainee::UserTasksController, type: :controller do
  let!(:user) {FactoryBot.create :user, role: :trainee}
  let!(:task) {FactoryBot.create :task}
  let(:task_1) {FactoryBot.create :task}
  let!(:user_course_subject) {FactoryBot.create :user_course_subject, user: user}
  let!(:user_task) {FactoryBot.create :user_task, user_course_subject: user_course_subject, task_id: task.id}

  before {login user}

  describe "PATCH #update" do
    context "when valid param" do
      before do
        patch :update, params: {id: user_task.id, user_task: {
            task_id: task.id, user_course_subject_id: user_course_subject.id}
        }, format: :js
      end

      it "should response js" do
        expect(response).to render_template :update
      end

      it "should change user_task status to 'done'" do
        expect(assigns(:user_task).status_done?).to eq true
      end
    end

    context "when invalid param" do
      before do
        patch :update, params: {id: user_task.id,
                                user_task: {
                                    task_id: task.id,
                                    user_course_subject_id: user_course_subject.id+1,
                                    status: :inprogress}
        }, format: :json
      end

      it "should response json with err message" do
        allow_any_instance_of(UserTask).to receive(:update).and_return(false)
        expect(JSON.parse(response.body)["err"]).to eq "Update failed!"
      end
    end
  end
end
