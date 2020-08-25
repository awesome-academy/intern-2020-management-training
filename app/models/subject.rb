class Subject < ApplicationRecord
  SUBJECT_NAME_REGEX = Settings.REGEX.model.subject.name
  PERMITTED_CREATE_ATTRS = [:name, :duration, :note, :image,
    task_attributes: [:id, :subject_id, :name, :_destroy].freeze].freeze

  has_many :tasks, dependent: :destroy
  has_one_attached :image
  accepts_nested_attributes_for :tasks, allow_destroy: true,
    reject_if: :reject_tasks

  validates :name, presence: true, uniqueness: true,
            length: {
              minimum: Settings.validates.model.subject.name.min_length,
              maximum: Settings.validates.model.subject.name.max_length
            },
            format: {with: SUBJECT_NAME_REGEX}
  validates :duration, presence: true,
            numericality: {
              greater_than: Settings.validates.model.subject.duration.min
            }
  validates :note, allow_nil: true,
            length: {
              maximum: Settings.validates.model.subject.note.max_length
            }
  validates :image,
            content_type: {
              in: Settings.validates.model.subject.image.content_type,
              message: I18n.t("model.subject.validates.image_type")
            },
            size: {
              less_than: Settings.validates.model.subject.image.max_size.MB,
              message: I18n.t("model.subject.validates.size")
            }

  private

  def reject_tasks attributes
    attributes["name"].blank?
  end
end
