class CreateSubjects < ActiveRecord::Migration[6.0]
  def change
    create_table :subjects do |t|
      t.string :name, :null => false
      t.float :duration
      t.string :image
      t.text :note

      t.timestamps
    end
  end
end
