FactoryBot.define do
  factory :order_item do
    quantity { 1 }
    order { nil }
    book { nil }
  end
end
