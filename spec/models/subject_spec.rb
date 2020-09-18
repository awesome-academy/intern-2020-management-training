require 'rails_helper'

RSpec.describe Subject, type: :model do
  IMG_MAX_SIZE = Settings.validates.model.subject.image.max_size.MB

  let!(:subject_1) {FactoryBot.create :subject, name: "it_test", created_at: "2020-09-06 05:48:12", duration: 3.0}
  let(:invalid_subject) {FactoryBot.build :subject, name: "it * test"}
  let!(:subject_2) {FactoryBot.create :subject, name: "subject 2", created_at: "2020-09-07 05:48:12", duration: 3.5}
  let!(:course) {FactoryBot.create :course, name: "course_1"}

  let!(:cs_1) {FactoryBot.create :course_subject, course: course, subject: subject_1, status: "inprogress"}
  let!(:cs_2) {FactoryBot.create :course_subject, course: course, subject: subject_2, status: "finished"}

  describe "Validations" do
    it {is_expected.to validate_presence_of(:name)}

    it {is_expected.to validate_length_of(:name)
      .is_at_least(Settings.validates.model.subject.name.min_length)
      .is_at_most(Settings.validates.model.subject.name.max_length)}

    it {is_expected.to validate_uniqueness_of(:name)}

    it "format is invalid" do
      expect(invalid_subject).not_to match Settings.REGEX.model.subject.name
    end

    it {is_expected.to validate_presence_of(:duration)}

    it {is_expected.to validate_numericality_of(:duration)
      .is_greater_than Settings.validates.model.subject.duration.min}

    it {is_expected.to validate_length_of(:note).is_at_most Settings.validates.model.subject.note.max_length}

    it "img size is invalid" do
      expect(subject_1.image.size).to be < IMG_MAX_SIZE * 1024 * 1024
    end

    it "number of task is invalid" do
      expect(subject_1.tasks.size).to be >= Settings.validates.model.subject.task_min_size
    end
  end

  describe "Associations" do
    [:tasks, :course_subjetcs, :courses, :topic_subjetcs, :topics].each do |model|
      it {have_many(model)}
    end
  end

  describe "Nested attribute" do
    it {accept_nested_attributes_for(:tasks).allow_destroy(true)}
  end

  describe "Scopes" do
    describe ".by_name" do
      context "when nil param" do
        it "return all subject" do
          expect(Subject.by_name(nil)).to eq([subject_1, subject_2])
        end
      end

      context "when valid param" do
        it "return subject" do
          expect(Subject.by_name("it_test").first).to eq(subject_1)
        end
      end
    end

    describe ".exclude_ids" do
      context "when empty params" do
        it "return all subject has id out of ids list" do
          expect(Subject.exclude_ids(nil).size).to eq(Subject.count)
        end
      end

      context "when valid param" do
        it "return subject" do
          expect(Subject.exclude_ids([subject_1.id]).pluck(:id)).to eq([subject_2.id])
        end
      end
    end

    describe ".by_created_at" do
      it "ordered subject list" do
        expect(Subject.by_created_at.last).to eq(subject_1)
      end
    end

    describe "total_time_subjects" do
      it "sum duration" do
        expect(Subject.total_time_subjects).to eq(subject_1.duration + subject_2.duration)
      end
    end

    describe ".by_course" do
      context "when nil param" do
        it "return all subject" do
          expect(Subject.by_course(nil).size).to eq(Subject.count)
        end
      end

      context "when valid param" do
        it "return subject of course with specified id" do
          expect(Subject.by_course(course.id).pluck(:id)).to eq([subject_1.id, subject_2.id])
        end
      end
    end

    describe ".by_id" do
      context "when nil id" do
        it "return all subject" do
          expect(Subject.by_id(nil).size).to eq(Subject.count)
        end
      end

      context "when valid id" do
        it "return subject with specified id" do
          expect(Subject.by_id(subject_1.id).pluck(:id)).to eq([subject_1.id])
        end
      end
    end
  end

  describe "#started_at" do
    it "start date of subject" do
      expect(subject_1.started_at).to eq "06-09-2020"
    end
  end

  describe "#ended_at" do
    context "with nil param" do
      it "nil value" do
        expect(subject_1.ended_at(nil)).to eq nil
      end
    end

    context "with valid param" do
      it "expected end date of course" do
        expect(subject_1.ended_at(subject_1.started_at)).to eq "09-09-2020"
      end
    end
  end

  describe "#find_course_subject_by_course" do
    context "with nil param" do
      it "nil value" do
        expect(subject_1.find_course_subject_by_course(nil)).to eq nil
      end
    end

    context "with valid param" do
      it "first course subject of subject with course_id" do
        expect(subject_1.find_course_subject_by_course(course.id)).to eq cs_1
      end
    end
  end

  describe "#active_course" do
    it "course subject with status active" do
      expect(subject_1.active_course.pluck(:id)).to eq [subject_1.id]
    end
  end

  describe "#subject_progress" do
    context "with nill param" do
      it "zero value" do
        expect(subject_1.subject_progress(nil, nil)).to eq 0
      end
    end

    context "with valid param" do
      let!(:user) {FactoryBot.create :user, id: 1}
      let!(:ucs) {FactoryBot.create :user_course_subject, user: user, course_subject: cs_1, progress: 13.13}

      it "subject progress of user in the course" do
        expect(subject_1.subject_progress(user.id, course.id)).to eq ucs.progress
      end
    end
  end
end
