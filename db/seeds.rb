require 'ffaker'

#AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

Address.create(first_name: FFaker::Name.first_name,
               last_name: FFaker::Name.last_name,
               address: FFaker::AddressUS.street_address,
               city: FFaker::AddressUS.city,
               zip: FFaker::AddressUS.zip_code,
               country: FFaker::AddressUS.country,
               phone: FFaker::PhoneNumber.phone_calling_code + FFaker::PhoneNumber.phone_number,
               address_type: 0,
               user_id: 7)
