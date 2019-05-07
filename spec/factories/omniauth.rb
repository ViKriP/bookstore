FactoryBot.define do
  factory :auth_hash, class: OmniAuth::AuthHash do
    initialize_with do
      OmniAuth::AuthHash.new({
        provider: provider,
        uid: uid,
        info: {
          email: email
        }
      })
    end

    trait :facebook do
      provider { "facebook" }
      sequence(:uid)
      email { "testuser@facebook.com" }
    end

    trait :does_not_persist do
      email { "" }
    end
  end
end