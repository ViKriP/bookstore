class AddActiveToCoupons < ActiveRecord::Migration[5.2]
  def change
    add_column :coupons, :active, :boolean, default: true
  end
end
