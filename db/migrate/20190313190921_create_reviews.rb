class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.string :title
      t.text :comment
      t.boolean :approved

      t.timestamps
    end
  end
end
