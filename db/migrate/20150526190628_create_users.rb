class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.references :institution, index: true, foreign_key: true
      t.string :email
      t.string :name
      t.string :password_digest
      t.string :reset_password_token
      t.string :auth_token, index: true
      t.string :role

      t.timestamps null: false
    end
  end
end
