class UserTask < ApplicationRecord
  belongs_to :user_course_subject
  belongs_to :task

  enum status: {done: 1, doing: 0}, _prefix: true

  scope :task_done, ->{status_done.group :user_course_subject_id}
  scope :task_status, (lambda do |user_id, course_id|
    select("status").joins([user_course_subject: :course_subject])
    .where(user_course_subjects: {user_id: user_id},
      course_subjects: {course_id: course_id})
  end)
end
