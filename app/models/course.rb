class Course < ApplicationRecord
  COURSE_PARAMS_PERMIT = [:name, :note, :image,
                          course_subjects_attributes: [:id, :subject_id],
                          user_courses_attributes: [:id, :user_id]].freeze

  has_many :course_subjects, dependent: :destroy
  has_many :subjects, through: :course_subjects
  has_many :user_courses, dependent: :destroy
  has_many :trainees, through: :user_courses, source: :user
  has_many :user_course_subjects, through: :course_subjects

  accepts_nested_attributes_for :course_subjects, :user_courses

  validates :name, presence: true,
            length: {minimum: Settings.validates.model.course.min_length,
                     maximum: Settings.validates.model.course.max_length},
            uniqueness: {case_sensitive: false}
  validates :note, allow_nil: true,
            length: {maximum: Settings.validates.model.course.max_length}
  validates :image,
            content_type: {
              in: Settings.validates.model.subject.image.content_type,
              message: I18n.t("model.subject.validates.image_type")
            },
            size: {
              less_than: Settings.validates.model.subject.image.max_size.MB,
              message: I18n.t("model.subject.validates.size")
            }

  enum status: {deleted: 0, finished: 1, postponed: 2, opening: 3}

  scope :order_by_start_date, ->{order start_date: :desc}
  scope :order_by_status, ->{order status: :desc}

  def progress_by_user user_id
    user_course = user_courses.find_by user_id: user_id
    user_course.progress
  end
end
