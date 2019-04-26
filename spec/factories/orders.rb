FactoryBot.define do
  factory :order do
    user
    discount { 1 }
    state { 'in_progress' }
  end
end
