class AddMigrationToSongs < ActiveRecord::Migration[5.1]
  def change
    add_column :songs, :category, :integer
  end
end
