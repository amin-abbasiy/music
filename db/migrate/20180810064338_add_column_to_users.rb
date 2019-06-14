class AddColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string
    add_column :users, :email, :string
    add_column :users, :password_digest, :string
    add_column :users, :activated, :boolean
    add_column :users, :activation_digest, :string
    add_column :users, :login_digest, :string
    add_column :users, :admin, :boolean, default: false
  end
end
