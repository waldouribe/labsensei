class CreateCreatinineTests < ActiveRecord::Migration
  def change
    create_table :creatinine_tests do |t|
      t.references :institution, index: true, foreign_key: true
      t.references :patient, index: true, foreign_key: true
      t.string :private_id
      t.float :level
      t.datetime :performed_at

      t.timestamps null: false
    end
  end
end
