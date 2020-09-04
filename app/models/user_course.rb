class UserCourse < ApplicationRecord
  belongs_to :user
  belongs_to :course

  scope :by_course, ->(id){where course_id: id if id.present?}
end
