require "rails_helper"

RSpec.describe Task, type: :model do
  subject {FactoryBot.build :task, name: "Task 12"}
  let(:user_1) {FactoryBot.create :user}
  let(:course_1) {FactoryBot.create :course}
  let!(:task_1) {FactoryBot.create :task}

  describe "Validations"  do
    it {is_expected.to validate_presence_of(:name)}

    it {is_expected.to validate_length_of(:name)
                           .is_at_least(Settings.validates.model.task.name.min_length)
                           .is_at_most(Settings.validates.model.task.name.max_length)}
  end

  describe "Associations" do
    it {belong_to :subject}

    it {have_many :user_tasks}
  end

  describe "Scope" do
    describe ".by_id" do
      context "with valid param" do
        it "should return list tasks which has id in list" do
          expect(Task.by_id([task_1.id]).pluck(:id)).to eq [task_1.id]
        end
      end

      context "with nil params" do
        it "should return all task" do
          expect(Task.by_id(nil).count).to eq Task.count
        end
      end
    end
  end

  describe "#status_by_user_course_subject" do
    context "with invalid param" do
      it "should return nil" do
        allow_any_instance_of(Task).to receive(:status_by_user_course_subject).with(nil, nil).and_return nil
        expect(task_1.status_by_user_course_subject(nil, nil)).to eq nil
      end
    end

    context "with valid param" do
      let!(:user_task_1) {FactoryBot.create :user_task, task_id: task_1.id}
      it "should return status of task" do
        allow_any_instance_of(Task).to receive(:status_by_user_course_subject).with(user_1.id, course_1).and_return user_task_1.status
        expect(task_1.status_by_user_course_subject(user_1.id, course_1)).to eq user_task_1.status
      end
    end
  end

  describe "#user_task_by_course_user" do
    context "with invalid param" do
      it "should return nil" do
        allow_any_instance_of(Task).to receive(:user_task_by_course_user).with(nil, nil).and_return nil
        expect(task_1.user_task_by_course_user(nil, nil)).to eq nil
      end
    end

    context "with valid param" do
      let!(:user_task_1) {FactoryBot.create :user_task, task_id: task_1.id}
      it "should return user task" do
        allow_any_instance_of(Task).to receive(:user_task_by_course_user).with(user_1.id, course_1).and_return user_task_1
        expect(task_1.user_task_by_course_user(user_1.id, course_1).id).to eq user_task_1.id
      end
    end
  end
end
