class CreateJoinTableCategoryBook < ActiveRecord::Migration[5.2]
  def change
    create_join_table :categories, :books do |t|
      t.index [:category_id, :book_id], unique: true
      t.index [:book_id, :category_id]
    end
  end
end
