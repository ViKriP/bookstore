FactoryBot.define do
  factory :review do
    user { nil }
    book { nil }
    title { "MyString" }
    comment { "MyText" }
    approved { false }
  end
end
