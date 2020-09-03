class CreateCourseSubjects < ActiveRecord::Migration[6.0]
  def change
    create_table :course_subjects do |t|
      t.integer :subject_id
      t.integer :course_id
      t.integer :status
      t.datetime :start_date

      t.timestamps
    end
    add_index :course_subjects, :subject_id
    add_index :course_subjects, :course_id
    add_index :course_subjects, [:subject_id, :course_id], unique: true
  end
end
