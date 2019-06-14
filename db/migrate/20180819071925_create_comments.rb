class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :song_id
      t.integer :user_id

      t.timestamps
    end
      add_index :comments, :song_id
      add_index :comments, :user_id
  end
end
