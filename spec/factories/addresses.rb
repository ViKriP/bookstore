FactoryBot.define do
  factory :address do
    first_name { FFaker::NameRU.first_name }
    last_name { FFaker::NameRU.last_name }
    sequence(:address) { |n| "#{n} Kensington Street" }
    city { 'Dnepr' }
    zip { 5555 }
    country { 'UA' }
    phone { '+38099888776'}
    association :addressable, factory: :user

    factory :billing_address, class: BillingAddress do
      type { 'BillingAddress' }
    end

    factory :shipping_address, class: ShippingAddress do
      type { 'ShippingAddress' }
    end
  end
end
