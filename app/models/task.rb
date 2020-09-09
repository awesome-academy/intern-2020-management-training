class Task < ApplicationRecord
  belongs_to :subject, inverse_of: :tasks
  has_many :user_tasks, dependent: :destroy

  validates :name, presence: true,
                   length: {
                     minimum: Settings.validates.model.task.name.min_length,
                     maximum: Settings.validates.model.task.name.max_length
                   }

  scope :by_id, ->(ids){where id: ids if ids.present?}
end
