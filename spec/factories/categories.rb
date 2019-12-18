FactoryBot.define do
  factory :category do
    title { FFaker::NameRU.last_name }
  end
end
