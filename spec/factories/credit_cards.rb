FactoryBot.define do
  factory :credit_card do
    last4 { 1234567890123456 }
    exp_month { 12 }
    exp_year { 25 }
    name { FFaker::NameRU.last_name }
    order
  end
end
