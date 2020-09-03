class AddPriorityToCourseSubjects < ActiveRecord::Migration[6.0]
  def change
    add_column :course_subjects, :priority, :integer
  end
end
