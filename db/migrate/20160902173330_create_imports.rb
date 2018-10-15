class CreateImports < ActiveRecord::Migration
  def change
    create_table :imports do |t|
      t.references :user, index: true, foreign_key: true
      t.references :institution, index: true, foreign_key: true
      t.integer :total_rows
      t.integer :valid_rows
      t.integer :invalid_rows

      t.timestamps null: false
    end
  end
end
