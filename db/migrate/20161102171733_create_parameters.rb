class CreateParameters < ActiveRecord::Migration
  def change
    create_table :parameters do |t|
      t.references :parameter_group, index: true, foreign_key: true
      t.references :parameter_kind, index: true, foreign_key: true
      t.string :value_string
      t.boolean :value_boolean
      t.integer :value_integer
      t.decimal :value_decimal

      t.timestamps null: false
    end
  end
end
