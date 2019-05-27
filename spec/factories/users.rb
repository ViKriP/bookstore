FactoryBot.define do
  factory :user do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    email { FFaker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { Date.today }

    trait :with_addresses do
      after(:create) do |user|
        user.billing_address = create(:billing_address)
        user.shipping_address = create(:shipping_address)
        #user.address.billing = create(address: :billing)
        #user.address.shipping = create(address: :shipping)
      end
    end
  end
end