FactoryBot.define do
  factory :address do
    first_name { 'My first name' }
    last_name { 'My last name' }
    address { 'My address' }
    city { 'Dnepr' }
    zip { 5555 }
    country { 'Ukraine' }
    phone { '+0998887766' }
    address_type { 1 }
    user
  end
end
