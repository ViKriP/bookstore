FactoryBot.define do
  factory :order_item do
    quantity { 1 }
    order
    book
  end
end
