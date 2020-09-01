class ChangeDateTypeToCourses < ActiveRecord::Migration[6.0]
  def change
    change_column :courses, :start_date, :date
    change_column :courses, :end_date, :date
  end
end
