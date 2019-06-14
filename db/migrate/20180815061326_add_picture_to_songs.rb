class AddPictureToSongs < ActiveRecord::Migration[5.1]
  def change
    add_column :songs, :picture, :string
  end
end
