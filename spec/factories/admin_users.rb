FactoryBot.define do
    factory :admin_user do
      email { 'admin@example.com' } #FFaker::Internet.email }
      password { 'password' }
      password_confirmation { 'password' }
    end
  end
