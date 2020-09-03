class TopicSubject < ApplicationRecord
  belongs_to :subject
  belongs_to :topic
end
