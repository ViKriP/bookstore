class Book < ApplicationRecord
  has_many :book_authors
  has_many :authors, through: :book_authors
  has_many :book_categories
  has_many :categories, through: :book_categories
  has_many :reviews, dependent: :destroy
  has_many :order_items, dependent: :nullify
  has_many :orders, through: :order_items

  mount_uploaders :images, ImageUploader

  scope :title, ->(ord) { order(title: ord) }
  scope :price, ->(ord) { order(price: ord) }
  scope :created_at, ->(ord) { order(created_at: ord) }
  scope :popular, lambda { |ord|
    left_joins(:orders)
      .group(:id)
      .order(Arel.sql("COUNT(orders.id) #{ord}"))
  }
  validates :title, :price, :quantity, :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 1 }
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :year, numericality: { less_than_or_equal_to: Time.current.year }

  BOOKS_PER_PAGE = 12

  def ended?
    quantity.zero?
  end
end
