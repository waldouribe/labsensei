class CreateTriggers < ActiveRecord::Migration
  def change
    create_table :triggers do |t|
      t.references :parameter_kind, index: true, foreign_key: true
      t.references :arg0, index: true, foreign_key: true # ParameterKind 
      t.references :arg1, index: true, foreign_key: true # ParameterKind 
      t.references :alert_kind, index: true, foreign_key: true
      t.string :kind
      t.decimal :value
      t.boolean :is_custom, default: false
      t.string :klass
      t.string :function
      t.text :description

      t.timestamps null: false
    end
  end
end
