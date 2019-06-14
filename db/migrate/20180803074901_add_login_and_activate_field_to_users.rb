class AddLoginAndActivateFieldToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :login_digest, :string
    add_column :users, :activated, :boolean
  end
end
