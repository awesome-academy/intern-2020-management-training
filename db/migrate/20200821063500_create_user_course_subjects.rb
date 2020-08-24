class CreateUserCourseSubjects < ActiveRecord::Migration[6.0]
  def change
    create_table :user_course_subjects do |t|
      t.date :deadline
      t.integer :status
      t.references :user, null: false, foreign_key: true
      t.references :course_subject, null: false, foreign_key: true

      t.timestamps
    end
  end
end
