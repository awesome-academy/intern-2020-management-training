class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, null: false
      t.string :password
      t.datetime :date_of_birth
      t.integer :staff_type
      t.string :address
      t.integer :gender
      t.references :program_language, null: false, foreign_key: true
      t.references :position, null: false, foreign_key: true
      t.references :department, null: false, foreign_key: true
      t.references :school, null: false, foreign_key: true
      t.references :office, null: false, foreign_key: true

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
