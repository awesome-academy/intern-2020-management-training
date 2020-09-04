class UserTask < ApplicationRecord
  belongs_to :user_course_subject
  belongs_to :task

  enum status: {task_done: 1, task_not_done: 0}, _prefix: true
  scope :task_done, ->{status_task_done.group :user_course_subject_id}
end
