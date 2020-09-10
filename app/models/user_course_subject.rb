class UserCourseSubject < ApplicationRecord
  belongs_to :course_subject
  belongs_to :user
  has_many :user_tasks, dependent: :destroy

  delegate :course_id, to: :course_subject,
    prefix: Settings.prefix.course_subject

  enum status: {inprogress: 0, done: 1}

  scope :status, ->(status){where status: status if status.present?}
  scope :task_done, (lambda do |course_id|
    select("COUNT(user_tasks.user_course_subject_id) AS task_done,
           	course_subjects.subject_id")
        .joins(:course_subject, :user_tasks)
        .where(user_tasks: {status: Settings.validates.model.user_task.done},
               course_subjects: {id: course_id})
        .group("user_tasks.user_course_subject_id")
        .order(priority: :asc)
  end)
  scope :task_of_user, (lambda do |user_id|
    select("user_tasks.status AS user_task_status", "tasks.name")
        .joins(:course_subject, [user_tasks: :task])
        .where(user_course_subjects: {user_id: user_id})
  end)
  scope :by_user, ->(user_id){where user_id: user_id if user_id.present?}
  scope :by_subject, (lambda do |subject_id|
    where course_subjects: {subject_id: subject_id} if subject_id.present?
  end)
end
