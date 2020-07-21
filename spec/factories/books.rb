FactoryBot.define do
  factory :book do
    title { FFaker::Book.title }
    price { 30.99 }
    quantity { 5 }
    year { 2019 }
    height { 5.0 }
    width { 4.0 }
    depth { 3.0 }
    materials { 'Hardcove, glossy paper' }
    description { FFaker::Book.description }
    images { [File.open('spec/fixtures/images/default.png')] }

    trait :long_description do
      description { FFaker::Lorem.paragraphs.join }
    end
  end
end
