class CreditCard < ApplicationRecord
  before_validation :formatted_card_number

  VALID_CARD_NUMBER_REGEX = /\A[0-9]+\z/.freeze
  VALID_CVV_REGEX = /\A[0-9]+\z/.freeze
  VALID_CARDHOLDER_NAME_REGEX = /\A[a-z A-Z]+\z/.freeze
  VALID_EXP_DATE_REGEX = /\A[0-9]{2}\/[0-9]{2}\z/.freeze

  belongs_to :order
  
  validates :number, :exp_date, :cvv, :name, presence: true
  validates :number, length: { is: 16 }, format: { with: VALID_CARD_NUMBER_REGEX }
  validates :cvv, length: { in: 3..4 }, format: { with: VALID_CVV_REGEX }
  validates :name, length: { maximum: 50 }, format: { with: VALID_CARDHOLDER_NAME_REGEX }
  validates :exp_date, format: { with: VALID_EXP_DATE_REGEX }
  validate :exp_date_cannot_be_in_the_past

  private

  def formatted_card_number
    number&.delete!(' ')
  end

  def exp_date_cannot_be_in_the_past
    if exp_date.present? && exp_date_as_date_object.is_a?(Time) && exp_date_as_date_object < Time.zone.today
      errors.add(:exp_date, "can't be in the past")
    end
  end

  def exp_date_as_date_object
    splitted = exp_date.split('/')
    Time.zone.local('20' + splitted.last, splitted.first)
  rescue ArgumentError
    errors.add(:exp_date, 'month invalid')
  end
end
