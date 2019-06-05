FactoryBot.define do
  factory :coupon do
    code { 'r2tt5w' }
    discount { 10 }
    active { true }
  end
end
