require 'rails_helper'

RSpec.feature "Registrations", type: :feature do
  given(:valid_attributes) { attributes_for(:user) }

  scenario 'Visitor registers successfully via register form' do
    visit new_user_registration_path
    within '#new_user' do
      fill_in 'user[first_name]', with: valid_attributes[:first_name]
      fill_in 'user[last_name]', with: valid_attributes[:last_name]
      fill_in 'user[email]', with: valid_attributes[:email]
      fill_in 'user[password]', with: valid_attributes[:password]
      fill_in 'user[password_confirmation]', with: valid_attributes[:password_confirmation]
      click_button(I18n.t('signup'))
    end

    expect(page).to have_content I18n.t('devise.registrations.signed_up_but_unconfirmed')
  end

  scenario 'Registration failure' do
    visit new_user_registration_path
    within '#new_user' do
      fill_in 'user[first_name]', with: ''
      fill_in 'user[last_name]', with: ''
      fill_in 'user[email]', with: 'a'
      fill_in 'user[password]', with: '1'
      fill_in 'user[password_confirmation]', with: '2'
      click_button(I18n.t('signup'))
    end

    expect(page).to have_content I18n.t('devise.registrations.failure.first_name')
    expect(page).to have_content I18n.t('devise.registrations.failure.last_name')
    expect(page).to have_content I18n.t('devise.registrations.failure.email')
    expect(page).to have_content I18n.t('devise.registrations.failure.password')
    expect(page).to have_content I18n.t('devise.registrations.failure.password_confirmation')
  end
end
