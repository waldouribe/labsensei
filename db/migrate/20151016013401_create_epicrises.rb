class CreateEpicrises < ActiveRecord::Migration
  def change
    create_table :epicrises do |t|
      t.references :patient, index: true, foreign_key: true
      t.boolean :aki_diagnosis
      t.integer :aki_stage
      t.date :admission_date
      t.string :admission_unit
      t.date :discharge_date
      t.string :admission_unit
      t.string :admission_reason
      t.boolean :dead
      t.boolean :nephrology_assessment
      t.boolean :nephrology_appointment
      t.boolean :ckd
      t.boolean :rrt
      t.boolean :intrahospital_sepsis
      t.boolean :ami
      t.boolean :htn
      t.boolean :copd
      t.boolean :cld
      t.boolean :dm
      t.boolean :esrd
      t.boolean :tel

      t.timestamps null: false
    end
  end
end
