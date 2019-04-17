FactoryBot.define do
  factory :delivery do
    name { FFaker::Lorem.words.join }
    period { "MyString" }
    price { 1.55 }
  end
end
