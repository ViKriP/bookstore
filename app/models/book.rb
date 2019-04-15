class Book < ApplicationRecord
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :authors
  has_many :reviews, dependent: :destroy
  has_many :order_items, dependent: :nullify
  has_many :orders, through: :order_items

  mount_uploaders :images, ImageUploader

  validates :title, :price, :quantity, :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 1 }
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :year, numericality: { less_than_or_equal_to: Time.current.year }

  CAROUSEL_LIMIT = 3
  BESTSELLERS_LIMIT = 4
  SHORT_DESCRIPTION_LENGTH = 150
  BOOKS_PER_PAGE = 12

  def ended?
    quantity.zero?
  end
end
