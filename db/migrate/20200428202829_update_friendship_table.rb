class UpdateFriendshipTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :friendships, :confirm
    remove_column :friendships, :denied
    add_column :friendships, :status, :string
  end
end
