class CreateAlertKinds < ActiveRecord::Migration
  def change
    create_table :alert_kinds do |t|
      t.references :institution, index: true, foreign_key: true
      t.string :name
      t.integer :severity
      t.text :description

      t.timestamps null: false
    end
  end
end
