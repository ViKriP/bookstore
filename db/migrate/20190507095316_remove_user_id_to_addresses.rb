class RemoveUserIdToAddresses < ActiveRecord::Migration[5.2]
  def up
    remove_index :addresses, :user_id
    remove_column :addresses, :user_id
  end
  
  def down
    add_column :addresses, :user_id
    add_index :addresses, :user_id
  end
end
