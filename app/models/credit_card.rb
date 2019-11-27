class CreditCard < ApplicationRecord
  before_validation :formatted_card_number

  VALID_NUMBER_REGEX = /\A[0-9]+\z/.freeze
  VALID_CARDHOLDER_NAME_REGEX = /\A[a-z A-Z]+\z/.freeze
  MONTH_NUMBER_GREATER_THAN = 0
  MONTH_NUMBER_LESS_THAN = 13

  belongs_to :order

  validates :last4, :exp_month, :exp_year, :name, presence: true

  validates :last4, length: { is: 16 }, format: { with: VALID_NUMBER_REGEX }
  validates :exp_month, numericality: { only_integer: true,
                                        greater_than: MONTH_NUMBER_GREATER_THAN,
                                        less_than: MONTH_NUMBER_LESS_THAN }
  validates :exp_year, length: { is: 2 }, format: { with: VALID_NUMBER_REGEX }
  validates :name, length: { maximum: 50 }, format: { with: VALID_CARDHOLDER_NAME_REGEX }
  validate :exp_date_cannot_be_in_the_past

  private

  def formatted_card_number
    last4&.delete!(' ')
  end

  def exp_date_cannot_be_in_the_past
    exp_date = Date.new("20#{exp_year}".to_i, exp_month.to_i).past?

    errors.add(:exp_year, "can't be in the past") if exp_date
  rescue ArgumentError
    errors.add(:exp_year, 'date invalid')
  end
end
