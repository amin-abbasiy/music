class AddCatIdToSongs < ActiveRecord::Migration[5.1]
  def change
    add_column :songs, :category_id, :integer
  end
    add_index :songs, :category_id
end
