FactoryBot.define do
  factory :order do
    user
    discount { 1 }
    state { 'in_progress' }
    #delivery

    trait :with_addresses do
      after(:create) do |user|
        user.billing_address = create(:billing_address)
        user.shipping_address = create(:shipping_address)
      end
    end
  end
end
