class ChangeStatusCourseSubject < ActiveRecord::Migration[6.0]
  def change
    change_column_default :course_subjects, :status, 0
  end
end
