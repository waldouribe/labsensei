class CreateParameterKinds < ActiveRecord::Migration
  def change
    create_table :parameter_kinds do |t|
      t.references :parameter_group_kind, index: true, foreign_key: true
      t.string :name
      t.string :parameter_type# integer, decimal, string, boolean
      t.boolean :deductible, default: false
      t.string :units

      t.timestamps null: false
    end
  end
end
