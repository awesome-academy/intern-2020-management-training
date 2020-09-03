class CourseSubject < ApplicationRecord
  belongs_to :subject
  belongs_to :course
  has_many :user_course_subjects, dependent: :destroy

  validates :course_id, presence: true
  validates :subject_id, presence: true
end
