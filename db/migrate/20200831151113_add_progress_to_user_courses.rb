class AddProgressToUserCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :user_courses, :progress, :float, default: 0.0
  end
end
