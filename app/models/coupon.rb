class Coupon < ApplicationRecord
  validates :code, :discount, presence: true
  validates :discount, numericality: { greater_than_or_equal_to: 1 }
end
