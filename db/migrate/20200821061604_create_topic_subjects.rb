class CreateTopicSubjects < ActiveRecord::Migration[6.0]
  def change
    create_table :topic_subjects do |t|
      t.references :subject, null: false, foreign_key: true
      t.references :topic, null: false, foreign_key: true

      t.timestamps
    end
  end
end
