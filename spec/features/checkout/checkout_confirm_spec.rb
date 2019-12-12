require 'rails_helper'

feature 'Checkout' do
  given(:user) { create(:user, :with_addresses) }
  given(:book) { create(:book, :have_long_description_author) }
  given(:delivery) { create(:delivery) }
  given(:order) { create(:order) }
  given(:credit_card) { attributes_for(:credit_card) }

  context 'Confirm' do
    before do
      book
      login_as(user, scope: :user)

      visit root_path
      click_button(I18n.t('buy_now'))

      visit cart_path
      click_button(I18n.t('checkout'), match: :first)

      delivery
      click_button(I18n.t('save_and_continue'))
      click_button(I18n.t('save_and_continue'))

      fill_in 'order[credit_card_attributes][last4]', with: credit_card[:last4]
      fill_in 'order[credit_card_attributes][name]', with: credit_card[:name]
      fill_in 'order[credit_card_attributes][exp_month]', with: credit_card[:exp_month]
      fill_in 'order[credit_card_attributes][exp_year]', with: credit_card[:exp_year]
      fill_in 'order[credit_card_attributes][cvv]', with: 1234

      click_button(I18n.t('save_and_continue'))
    end

    scenario 'user redirected to confirm page' do
      expect(page).to have_current_path('/checkout/confirm')
      expect(page).to have_content I18n.t('billing_address')
      expect(page).to have_content I18n.t('shipping_address')
      expect(page).to have_content I18n.t('shipments')
      expect(page).to have_content I18n.t('payment_info')
      expect(page).to have_content book.title
    end

    scenario 'to click edit for address' do
      all(:xpath, ".//a[@href='/checkout/address']").first.click

      expect(page).to have_field 'order[billing_address_attributes][first_name]'
    end

    scenario 'to click edit for delivery' do
      find(:xpath, ".//a[@href='/checkout/delivery']").click

      expect(page).to have_content I18n.t('delivery.method')
    end

    scenario 'to click edit for payment' do
      find(:xpath, ".//a[@href='/checkout/payment']").click

      expect(page).to have_field 'order[credit_card_attributes][last4]'
    end

    scenario 'user redirected to complete page' do
      click_link(I18n.t('place_order'))

      expect(page).to have_current_path('/checkout/complete')
      expect(page).to have_content I18n.t('complete.thank_you')
    end
  end
end
