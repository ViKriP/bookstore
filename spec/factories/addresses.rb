FactoryBot.define do
  factory :address do
    first_name { "MyString" }
    last_name { "MyString" }
    address { "MyString" }
    city { "MyString" }
    zip { "MyString" }
    country { "MyString" }
    phone { "MyString" }
    type { 1 }
    user { nil }
  end
end
