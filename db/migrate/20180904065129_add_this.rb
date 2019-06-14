class AddThis < ActiveRecord::Migration[5.1]
  def change
    create_table :conversations do |t|
      t.integer :sender_id
      t.integer :recipient_id

      t.timestamps
    end
    create_table :messages do |t|
      t.string :body
      t.references :conversation, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :conversations, :sender_id
    add_index :conversations, :recipient_id
  end
end
