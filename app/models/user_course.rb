class UserCourse < ApplicationRecord
  belongs_to :user
  belongs_to :course

  validates :course_id, presence: true
  validates :user_id, presence: true
end
