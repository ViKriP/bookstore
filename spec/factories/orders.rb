FactoryBot.define do
  factory :order do
    user { nil }
    discount { 1 }
    state { "MyString" }
  end
end
