class Course < ApplicationRecord
  COURSE_PARAMS_PERMIT = [:name, :note, :image,
                          course_subjects_attributes: [:id, :subject_id,
                                                       :priority, :_destroy],
                          user_courses_attributes: [:id, :user_id,
                                                    :_destroy]].freeze

  has_many :course_subjects, dependent: :destroy
  has_many :subjects, through: :course_subjects
  has_many :user_courses, dependent: :destroy
  has_many :trainees, through: :user_courses, source: :user
  has_many :user_course_subjects, through: :course_subjects
  has_many :users, through: :user_courses, dependent: :destroy
  has_many :reports, dependent: :destroy

  accepts_nested_attributes_for :course_subjects, :user_courses,
                                allow_destroy: true

  validates :name, presence: true,
            length: {minimum: Settings.validates.model.course.min_length,
                     maximum: Settings.validates.model.course.max_length},
            uniqueness: {case_sensitive: false}
  validates :note, allow_nil: true,
            length: {maximum: Settings.validates.model.course.max_length}
  validates :image, presence: true

  mount_uploader :image, CourseUploader

  enum status: {deleted: 0, finished: 1, postponed: 2, opening: 3}

  scope :order_by_start_date, ->{order start_date: :desc}
  scope :order_by_status, ->{order status: :desc}
  scope :join_user_course, ->{includes(:user_courses)}

  def progress_by_user user_id
    user_course = user_courses.find_by user_id: user_id
    return if user_course.blank?

    user_course.progress
  end

  def stated_at
    created_at.strftime Settings.validates.model.course.date_format
  end

  def ended_at duration
    ended_at = created_at + duration.to_int.days
    ended_at.strftime Settings.validates.model.course.date_format
  end

  def updated_at_custom
    updated_at.strftime Settings.validates.model.course.date_format
  end
end
