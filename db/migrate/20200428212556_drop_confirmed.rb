class DropConfirmed < ActiveRecord::Migration[5.2]
  def change
    remove_column :friendships, :confirmed
  end
end
