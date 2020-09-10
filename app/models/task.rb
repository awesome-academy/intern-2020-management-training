class Task < ApplicationRecord
  belongs_to :subject, inverse_of: :tasks
  has_many :user_tasks, dependent: :destroy

  validates :name, presence: true,
                   length: {
                     minimum: Settings.validates.model.task.name.min_length,
                     maximum: Settings.validates.model.task.name.max_length
                   }

  scope :by_id, ->(ids){where id: ids if ids.present?}

  def status_by_user_course_subject user_id, course_id
    user_task = user_tasks.task_status(user_id, course_id).first
    user_task&.status
  end

  def user_task_by_course_user user_id, course_id
    course_subject = subject.course_subjects.find_by course_id: course_id
    ucs = course_subject.user_course_subjects.find_by user_id: user_id
    return if ucs.blank?

    user_tasks.find_by user_course_subject_id: ucs.id
  end
end
