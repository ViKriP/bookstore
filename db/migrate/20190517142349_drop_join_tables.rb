class DropJoinTables < ActiveRecord::Migration[5.2]
  def change
    drop_table :authors_books
    drop_table :books_categories
  end
end
