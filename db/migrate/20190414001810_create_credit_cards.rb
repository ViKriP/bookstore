class CreateCreditCards < ActiveRecord::Migration[5.2]
  def change
    create_table :credit_cards do |t|
      t.string :name
      t.integer :number
      t.string :exp_date
      t.integer :cvv
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
