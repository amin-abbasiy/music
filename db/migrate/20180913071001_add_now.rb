class AddNow < ActiveRecord::Migration[5.1]
  def change
  end
  add_index :likes, [:user_id, :song_id], unique: true
end
