
FactoryBot.define do
  factory :author do
    first_name { FFaker::NameRU.first_name }
    last_name { FFaker::NameRU.last_name }
  end
end
