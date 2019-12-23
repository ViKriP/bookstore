FactoryBot.define do
  factory :auth_hash, class: OmniAuth::AuthHash do
    initialize_with do
      OmniAuth::AuthHash.new({
        provider: provider,
        uid: uid,
        info: {
          email: email,
          provider: provider,
          uid: uid,
          first_name: first_name,
          last_name: last_name
        }
      })
    end

    trait :facebook do
      provider { 'facebook' }
      sequence(:uid)
      email { 'testuser@facebook.com' }
      first_name { FFaker::NameRU.first_name }
      last_name { FFaker::NameRU.last_name }
    end

    trait :does_not_persist do
      email { '' }
    end
  end
end
