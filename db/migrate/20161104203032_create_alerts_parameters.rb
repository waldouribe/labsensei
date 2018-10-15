class CreateAlertsParameters < ActiveRecord::Migration
  def change
    create_table :alerts_parameters, id: false do |t|
      t.references :alert, index: true, foreign_key: true
      t.references :parameter, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
