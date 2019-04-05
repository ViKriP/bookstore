FactoryBot.define do
  factory :user do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    email { FFaker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { Date.today }
    #address_type { :billing }

    #trait :with_addresses do
    #  after(:create) do |user|
    # user.addresses.billing
    #    user.address.billing = create(address: :billing)
    #    user.address.shipping = create(address: :shipping)
    #  end
    #end
  end
end