class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.float :price
      t.integer :quantity
      t.integer :year
      t.text :description
      t.float :height
      t.float :width
      t.float :depth
      t.string :materials

      t.timestamps
    end
  end
end
