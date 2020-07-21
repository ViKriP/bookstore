class ChangeReferencesToCreditCards < ActiveRecord::Migration[5.2]
  def self.up
    remove_reference :credit_cards, :user, index: true
    add_reference :credit_cards, :order, index: true
  end
  
  def self.down
    add_reference :credit_cards, :user, index: true
    remove_reference :credit_cards, :order, index: true
  end
end
