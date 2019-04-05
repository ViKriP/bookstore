class Address < ApplicationRecord
  VALID_NAMES_REGEX = /\A[a-z A-Z]+\z/.freeze
  VALID_ADDRESS_REGEX = /\A[a-z A-Z,-]+\z/.freeze
  VALID_ZIP_REGEX = /\A[0-9]+\z/.freeze
  VALID_PHONE_REGEX = /\A^\+[0-9]+\z/.freeze

  belongs_to :user
  enum address_type: { billing: 0, shipping: 1 }

  #validates :user, presence: true
  validates :first_name, :last_name, :address, :city, :zip, :country, :phone, presence: true
  validates :first_name, :last_name, :address, :city, length: { maximum: 50, too_long: '50 characters only' }
  validates :first_name, :last_name, :city,
            format: { with: VALID_NAMES_REGEX, message: 'only allows letters' }
  validates :address,
            format: { with: VALID_ADDRESS_REGEX, message: "only allows letters, commas and '-' symbol" }
  validates :zip, length: { maximum: 10 },
                  format: { with: VALID_ZIP_REGEX, message: 'only allows numbers' }
  validates :phone, length: { maximum: 15 },
                    format: { with: VALID_PHONE_REGEX, message: 'should start with +' }

  def country_name
    ISO3166::Country[country].name
  end
end
