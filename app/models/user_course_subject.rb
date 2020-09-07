class UserCourseSubject < ApplicationRecord
  belongs_to :course_subject
  belongs_to :user
  has_many :user_tasks, dependent: :destroy

  enum status: {inprogress: 0, done: 1}

  scope :status, ->(status){where status: status if status.present?}
  scope :task_done, (lambda do
    select("COUNT(user_tasks.user_course_subject_id) AS task_done")
        .joins(:course_subject, :user_tasks)
        .where(user_tasks: {status: Settings.validates.model.user_task.done})
        .group("user_tasks.user_course_subject_id")
        .order(priority: :asc)
  end)
  scope :task_of_user, (lambda do |user_id|
    select("user_tasks.status, tasks.name")
        .joins(:course_subject, [user_tasks: :task])
        .where(user_course_subjects: {user_id: user_id})
  end)
  scope :by_user, ->(user_id){where user_id: user_id if user_id.present?}
end
