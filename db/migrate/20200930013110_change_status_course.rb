class ChangeStatusCourse < ActiveRecord::Migration[6.0]
  def change
    change_column_default :courses, :status, 3
  end
end
