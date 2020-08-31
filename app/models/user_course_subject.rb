class UserCourseSubject < ApplicationRecord
  belongs_to :course_subject
  has_many :user_task, dependent: :destroy
end
