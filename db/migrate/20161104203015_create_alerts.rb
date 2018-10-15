class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.references :patient
      t.references :alert_kind
      t.references :parameter
      t.datetime :date

      t.timestamps null: false
    end
  end
end
