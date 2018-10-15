class CreateParameterGroupKinds < ActiveRecord::Migration
  def change
    create_table :parameter_group_kinds do |t|
      t.references :institution
      t.string :name

      t.timestamps null: false
    end
  end
end
