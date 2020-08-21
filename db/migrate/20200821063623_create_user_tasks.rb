class CreateUserTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :user_tasks do |t|
      t.integer :status
      t.references :task, null: false, foreign_key: true
      t.references :user_course_subject, null: false, foreign_key: true

      t.timestamps
    end
  end
end
