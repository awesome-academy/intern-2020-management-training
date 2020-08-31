class CourseSubject < ApplicationRecord
  belongs_to :subject
  has_many :user_course_subjects, dependent: :destroy
end
