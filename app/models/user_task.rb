class UserTask < ApplicationRecord
  belongs_to :tasks
  belongs_to :user_course_subject, dependent: :destroy

  enum status: {done: Settings.status.user_task.done,
                doing: Settings.status.user_task.doing}
end
