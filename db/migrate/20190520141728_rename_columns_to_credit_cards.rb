class RenameColumnsToCreditCards < ActiveRecord::Migration[5.2]
  def up
    rename_column :credit_cards, :number, :last4
    rename_column :credit_cards, :exp_date, :exp_month
    rename_column :credit_cards, :cvv, :exp_year
  end
  
  def down
    rename_column :credit_cards, :last4, :number
    rename_column :credit_cards, :exp_month, :exp_date
    rename_column :credit_cards, :exp_year, :cvv
  end
end
