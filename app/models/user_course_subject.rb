class UserCourseSubject < ApplicationRecord
  belongs_to :course_subject
  belongs_to :user
  has_many :user_tasks, dependent: :destroy

  enum status: {doing: Settings.status.user_course_subject.doing,
                done: Settings.status.user_course_subject.done}

  scope :by_course_subject, ->(ids){where course_subject_id: ids}
  scope :by_user, ->(user_id){where user_id: user_id}
  scope :status, ->(status){where status: status}
end
