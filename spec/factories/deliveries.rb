FactoryBot.define do
  factory :delivery do
    name { FFaker::Lorem.words.join }
    period { "2 to 5 days" }
    price { 1.55 }
  end
end
