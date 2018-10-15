class CreateColumns < ActiveRecord::Migration
  def change
    create_table :columns do |t|
      t.references :import_result, index: true, foreign_key: true
      t.string :column_name
      t.integer :column_number
      t.string :is_valid
      t.string :value
      t.string :error

      t.timestamps null: false
    end
  end
end
