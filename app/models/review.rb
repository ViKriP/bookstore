class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :title, presence: true, length: { maximum: 80 }
  validates :comment, presence: true, length: { maximum: 500 }
  validates :rating, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 5 }

  scope :approved, -> { where(approved: true) }
  scope :unapproved, -> { where(approved: false) }
end
