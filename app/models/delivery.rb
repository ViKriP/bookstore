class Delivery < ApplicationRecord
  has_many :orders

  validates :name, :period, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
