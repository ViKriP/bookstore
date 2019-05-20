class CreateGuestOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :guest_orders do |t|
      t.references :order, foreign_key: true
      t.string :guest_id

      t.timestamps
    end
  end
end
