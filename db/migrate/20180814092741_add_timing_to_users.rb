class AddTimingToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :created_at, :datetime
  end
end
