class DropGuestOrders < ActiveRecord::Migration[5.2]
  def change
    drop_table :guest_orders
  end
end
