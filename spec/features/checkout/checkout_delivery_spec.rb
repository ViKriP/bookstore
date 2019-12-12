require 'rails_helper'

feature 'Checkout' do
  given(:user_with_billing) { create(:user, :with_addresses) }
  given(:delivery) { create(:delivery) }
  given(:order) { create(:order) }

  context 'Delivery' do
    before do
      create(:book, :have_long_description_author)

      login_as(user_with_billing, scope: :user)

      visit root_path
      click_button(I18n.t('buy_now'))

      visit cart_path
      click_button(I18n.t('checkout'), match: :first)
    end

    scenario 'when there is delivery' do
      delivery
      click_button(I18n.t('save_and_continue'))

      expect(page).to have_content delivery.name
      expect(page).to have_content I18n.t('delivery.method')
      expect(page).to have_content I18n.t('delivery_label')
    end

    scenario 'when there is no delivery' do
      click_button(I18n.t('save_and_continue'))

      expect(page).to have_no_css('.form-group.radio.mt-0.mb-0')
    end

    scenario 'user redirected to payment page' do
      delivery
      click_button(I18n.t('save_and_continue'))
      click_button(I18n.t('save_and_continue'))

      expect(page).to have_current_path('/checkout/payment')
    end
  end
end
