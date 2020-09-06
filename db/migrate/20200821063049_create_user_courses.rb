class CreateUserCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :user_courses do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.integer :subject_id
      t.integer :user_id

      t.timestamps
    end
    add_index :user_courses, :subject_id
    add_index :user_courses, :user_id
    add_index :user_courses, [:subject_id, :user_id], unique: true
  end
end
