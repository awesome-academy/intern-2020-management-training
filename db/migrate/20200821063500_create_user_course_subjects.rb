class CreateUserCourseSubjects < ActiveRecord::Migration[6.0]
  def change
    create_table :user_course_subjects do |t|
      t.date :deadline
      t.integer :status
      t.integer :course_subject_id
      t.integer :user_id

      t.timestamps
    end
    add_index :user_course_subjects, :course_subject_id
    add_index :user_course_subjects, :user_id
    add_index :user_course_subjects, [:course_subject_id, :user_id], unique: true
  end
end
