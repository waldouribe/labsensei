class CreateImportResults < ActiveRecord::Migration
  def change
    create_table :import_results do |t|
      t.references :import, index: true, foreign_key: true
      t.integer :row_number
      t.references :patient, index: true, foreign_key: true
      t.references :creatinine_test, index: true, foreign_key: true
      t.boolean :is_valid

      t.timestamps null: false
    end
  end
end
