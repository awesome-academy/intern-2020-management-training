class CourseSubject < ApplicationRecord
  belongs_to :subject
  has_many :user_course_subjects, dependent: :destroy

  enum status: {start: Settings.status.course_subject.start,
                inprogress: Settings.status.course_subject.inprogress,
                pending: Settings.status.course_subject.pending,
                finished: Settings.status.course_subject.finished}
end
