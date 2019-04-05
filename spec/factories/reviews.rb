FactoryBot.define do
  factory :review do
    user
    book
    title { 'Test title' }
    comment { 'Test comment' }
    approved { true }
    rating { 5 }
  end
end
