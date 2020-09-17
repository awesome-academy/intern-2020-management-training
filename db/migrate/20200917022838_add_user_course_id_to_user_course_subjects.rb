class AddUserCourseIdToUserCourseSubjects < ActiveRecord::Migration[6.0]
  def change
    add_column :user_course_subjects, :user_course_id, :integer
  end
end
