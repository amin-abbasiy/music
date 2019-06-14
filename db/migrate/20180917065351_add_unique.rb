class AddUnique < ActiveRecord::Migration[5.1]
  def change
    add_index :usercats, [:user_id, :category_id], unique: true
  end
end
