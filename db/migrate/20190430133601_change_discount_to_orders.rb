class ChangeDiscountToOrders < ActiveRecord::Migration[5.2]
  def self.up
    change_column :orders, :discount, :integer, default: 0
  end
  
  def self.down
    change_column :orders, :discount, :integer
  end
end
