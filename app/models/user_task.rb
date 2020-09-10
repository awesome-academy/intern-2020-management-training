class UserTask < ApplicationRecord
  PERMITTED_CREATE_ATTRS = %i(task_id status user_course_subject_id).freeze
  belongs_to :task
  belongs_to :user_course_subject

  before_save :edit_status_param
  after_save :update_subject_progress

  validates :task_id, presence: true
  validates :user_course_subject_id, presence: true
  validates :status, presence: true

  enum status: {done: 1, inprogress: 0}, _prefix: true

  scope :task_done, ->{status_task_done.group :user_course_subject_id}
  scope :task_status, (lambda do |user_id, course_id|
    select("status").joins([user_course_subject: :course_subject])
    .where(user_course_subjects: {user_id: user_id},
    course_subjects: {course_id: course_id})
  end)

  private

  def update_subject_progress
    all_task = user_course_subject.user_tasks
    done_task = all_task.where status: Settings.status_text.done
    return if all_task.blank?

    user_course_subject.update progress: done_task.size * 100.0 / all_task.size
  end

  def edit_status_param
    self.status = Settings.status_text.done
  end
end
