class Course < ApplicationRecord
  COURSE_PARAMS_PERMIT = [:name, :note, :image,
                          course_subjects_attributes: [:id, :subject_id],
                          user_courses_attributes: [:id, :user_id]].freeze

  has_many :course_subjects, dependent: :destroy
  has_many :subjects, through: :course_subjects
  has_many :user_courses, dependent: :destroy
  has_many :users, through: :user_courses
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
end
