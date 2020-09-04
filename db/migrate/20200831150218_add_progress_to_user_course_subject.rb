class AddProgressToUserCourseSubject < ActiveRecord::Migration[6.0]
  def change
    add_column :user_course_subjects, :progress, :float, default: 0.0
  end
end
