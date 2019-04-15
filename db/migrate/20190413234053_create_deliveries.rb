class CreateDeliveries < ActiveRecord::Migration[5.2]
  def change
    create_table :deliveries do |t|
      t.string :name
      t.string :period
      t.float :price

      t.timestamps
    end
  end
end
