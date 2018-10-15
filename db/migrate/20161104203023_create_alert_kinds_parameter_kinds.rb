class CreateAlertKindsParameterKinds < ActiveRecord::Migration
  def change
    create_table :alert_kinds_parameter_kinds, id: false do |t|
      t.references :alert_kind, index: true, foreign_key: true
      t.references :parameter_kind, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
