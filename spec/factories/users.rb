FactoryBot.define do
  factory :user do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    sequence(:email) { |n| "person#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { Date.today }

    trait :with_addresses do
      after(:create) do |user|
        user.billing_address = create(:billing_address)
        user.shipping_address = create(:shipping_address)
      end
    end
  end
end