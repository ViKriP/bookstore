class ChangeNumberAndCvvTypeToCreditCards < ActiveRecord::Migration[5.2]
  def self.up
    change_column :credit_cards, :number, :string
    change_column :credit_cards, :cvv, :string
  end 

  def self.down
    change_column :credit_cards, :number, :integer
    change_column :credit_cards, :cvv, :integer
  end 
end
