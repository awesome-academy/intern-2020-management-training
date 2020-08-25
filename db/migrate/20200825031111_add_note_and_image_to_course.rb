class AddNoteAndImageToCourse < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :note, :string
    add_column :courses, :image, :string
  end
end
