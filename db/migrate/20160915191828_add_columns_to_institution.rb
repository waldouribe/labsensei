class AddColumnsToInstitution < ActiveRecord::Migration
  def change
    add_reference :institutions, :plan, index: true, foreign_key: true
    add_column :institutions, :plan_status, :string, default: 'ok'
    add_column :institutions, :plan_expiration_date, :date
  end
end
