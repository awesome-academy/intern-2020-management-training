class Course < ApplicationRecord
  has_many :user_courses, dependent: :destroy
  has_many :course_subjects, dependent: :destroy
  has_many :trainees, through: :user_courses, source: :user
  has_many :user_course_subjects, through: :course_subjects
  has_many :subjects, through: :course_subjects

  enum status: {deleted: Settings.status.course.deleted,
                finished: Settings.status.course.finished,
                postponed: Settings.status.course.postponed,
                opening: Settings.status.course.opening}

  scope :by_start_date, ->{order start_date: :desc}
  scope :order_by_status, ->{order status: :desc}
end
