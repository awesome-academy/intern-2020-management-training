class CreateProgramLanguages < ActiveRecord::Migration[6.0]
  def change
    create_table :program_languages do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
