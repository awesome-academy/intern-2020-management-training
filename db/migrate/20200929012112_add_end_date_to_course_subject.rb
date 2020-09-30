class AddEndDateToCourseSubject < ActiveRecord::Migration[6.0]
  def change
    add_column :course_subjects, :end_date, :datetime
  end
end
