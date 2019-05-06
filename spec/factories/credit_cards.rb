FactoryBot.define do
  factory :credit_card do
    number { '1234567890123456' }
    cvv { '333' }
    exp_date { '12/25' }
    name { FFaker::Name.html_safe_name }
    order

    trait :skip_validate do
      to_create {|instance| instance.save(validate: false)}
    end
  end
end
