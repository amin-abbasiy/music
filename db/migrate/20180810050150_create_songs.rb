class CreateSongs < ActiveRecord::Migration[5.1]
  def change
    create_table :songs do |t|
      t.string :content
      t.string :file
      t.integer :like
      t.string :comment
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :songs, [:user_id, :created_at]
  end
end
