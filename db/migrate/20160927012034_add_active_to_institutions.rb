class AddActiveToInstitutions < ActiveRecord::Migration
  def change
    add_column :institutions, :active, :boolean, default: true
  end
end
