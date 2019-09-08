FactoryBot.define do
  factory :category do
    title { FFaker::AddressUS.country_code } #'Web development'
  end
end
