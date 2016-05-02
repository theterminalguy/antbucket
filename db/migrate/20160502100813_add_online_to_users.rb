class AddOnlineToUsers < ActiveRecord::Migration
  def change
    add_column :users, :online, :boolean, default: false 
  end
end
