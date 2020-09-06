class CreateUserTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :user_tasks do |t|
      t.integer :status
      t.integer :task_id
      t.integer :user_course_subject_id      

      t.timestamps
    end
    add_index :user_tasks, :user_course_subject_id
    add_index :user_tasks, :task_id
    add_index :user_tasks, [:user_course_subject_id, :user_id], unique: true
  end
end
