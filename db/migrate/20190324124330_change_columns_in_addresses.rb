class ChangeColumnsInAddresses < ActiveRecord::Migration[5.2]
  def self.up
    change_column :addresses, :first_name, :string, null: true
    change_column :addresses, :last_name, :string, null: true
    change_column :addresses, :address, :string, null: true
    change_column :addresses, :city, :string, null: true
    change_column :addresses, :zip, :string, null: true
    change_column :addresses, :country, :string, null: true
    change_column :addresses, :phone, :string, null: true
    change_column :addresses, :address_type, :integer, null: true
  end
  
  def self.down
    change_column :addresses, :first_name, :string, null: false
    change_column :addresses, :last_name, :string, null: false
    change_column :addresses, :address, :string, null: false
    change_column :addresses, :city, :string, null: false
    change_column :addresses, :zip, :string, null: false
    change_column :addresses, :country, :string, null: false
    change_column :addresses, :phone, :string, null: false
    change_column :addresses, :address_type, :integer, null: false
  end
end
