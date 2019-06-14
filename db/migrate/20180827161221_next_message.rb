class NextMessage < ActiveRecord::Migration[5.1]
  def change
     add_index :messages, :sender_id
     add_index :messages, :reciver_id
  end
end
