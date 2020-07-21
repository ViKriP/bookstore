class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :book

  validates :quantity, presence: true, numericality: { greater_than: 0, only_integer: true }
  validates :order_id, :book_id, presence: true
  validates :book_id, uniqueness: { scope: :order }
end
