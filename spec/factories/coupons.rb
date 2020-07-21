FactoryBot.define do
  factory :coupon do
    code { FFaker::Color.hex_code }
    discount { rand(10...40) }
    active { true }
  end
end
