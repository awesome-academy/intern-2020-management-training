class CreateUserCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :user_courses do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.integer :user_id
      t.integer :course_id

      t.timestamps
    end
    add_index :user_courses, :user_id
    add_index :user_courses, :course_id
    add_index :user_courses, [:user_id, :course_id], unique: true
  end
end
