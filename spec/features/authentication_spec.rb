require 'rails_helper'

RSpec.feature "Authentications", type: :feature do
  given(:user) { create(:user) }
  given(:invalid_password) { '@password' }

  context 'when user types valid account attributes' do
    before do
      visit new_user_session_path
      within '#new_user' do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button(I18n.t('back_to_store'))
      end
    end

    scenario 'Registered user authenticates successfully via log in form' do
      expect(page).to have_content I18n.t('devise.sessions.signed_in')
    end

    scenario 'Redirects to root path' do
      expect(page).to have_current_path root_path
    end
  end

  context 'when user types invalid account attributes' do
    before do
      visit new_user_session_path
      within '#new_user' do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: invalid_password
        click_button(I18n.t('back_to_store'))
      end
    end

    scenario 'Redirects to log in path' do
      expect(page).to have_current_path new_user_session_path
    end

    scenario 'Error message when authorization fails' do
      expect(page).to have_content I18n.t('invalid_auth')
    end
  end
end
