FactoryBot.define do
  factory :address do
    first_name { 'My first name' }
    last_name { 'My last name' }
    address { 'My address' }
    city { 'Dnepr' }
    zip { 5555 }
    country { 'Ukraine' }
    phone { '+0998887766' }
    association :addressable, factory: :user

    factory :billing_address, class: BillingAddress do
      type { 'BillingAddress' }
    end

    factory :shipping_address, class: ShippingAddress do
      type { 'ShippingAddress' }
    end
  end
end
