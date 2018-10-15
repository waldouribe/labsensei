class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.integer :max_cases
      t.integer :max_cases_per_month

      t.timestamps null: false
    end
  end
end
