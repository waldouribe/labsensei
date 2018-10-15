class CreateAkiDiagnoses < ActiveRecord::Migration
  def change
    create_table :aki_diagnoses do |t|
      t.references :patient, index: true, foreign_key: true
      t.integer :creatinine_test_1_id, index: true
      t.integer :creatinine_test_2_id, index: true
      t.integer :stage
      t.string :reason
      t.float :increase_net
      t.float :increase_percentage
      t.datetime :discovered_at
      t.integer :time_between_tests

      t.timestamps null: false
    end
  end
end
