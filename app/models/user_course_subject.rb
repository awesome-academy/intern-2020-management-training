class UserCourseSubject < ApplicationRecord
  belongs_to :course_subject
  belongs_to :user
  has_many :user_tasks, dependent: :destroy

  enum status: {doing: 0, done: 1}

  scope :status, ->(status){where status: status if status.present?}
end
