class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.references :institution, index: true, foreign_key: true
      t.string :private_id
      t.string :name
      t.string :email
      t.string :gender
      t.date :birthday

      t.timestamps null: false
    end
  end
end
