FactoryBot.define do
  factory :credit_card do
    name { "MyString" }
    number { 1 }
    exp_date { "MyString" }
    cvv { 1 }
    user { nil }
  end
end
