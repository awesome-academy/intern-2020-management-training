class Topic < ApplicationRecord
  has_many :topic_subjects, dependent: :destroy
  has_many :subjects, through: :topic_subjects

  scope :by_id, ->(id){where id: id if id.present?}
end
