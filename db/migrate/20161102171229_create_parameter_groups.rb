class CreateParameterGroups < ActiveRecord::Migration
  def change
    create_table :parameter_groups do |t|
      t.references :parameter_group_kind, index: true, foreign_key: true
      t.references :patient, index: true, foreign_key: true
      t.datetime :date

      t.timestamps null: false
    end
  end
end
