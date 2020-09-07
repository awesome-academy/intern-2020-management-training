class UserTask < ApplicationRecord
  belongs_to :user_course_subject
  belongs_to :task

  enum status: {done: 1, doing: 0}, _prefix: true
  scope :task_done, ->{status_done.group :user_course_subject_id}
end
