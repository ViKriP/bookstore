require 'rails_helper'

feature 'Checkout' do
  given(:user) { create(:user, :with_addresses) }
  given(:delivery) { create(:delivery) }
  given(:order) { create(:order) }
  given(:credit_card) { attributes_for(:credit_card) }

  context 'Payment' do
    before do
      create(:book, :long_description)

      login_as(user, scope: :user)

      visit root_path
      click_button(I18n.t('buy_now'))

      visit cart_path
      click_button(I18n.t('checkout'), match: :first)

      delivery
      click_button(I18n.t('save_and_continue'))
      click_button(I18n.t('save_and_continue'))
    end

    scenario 'user redirected to payment page' do
      expect(page).to have_current_path('/checkout/payment')
      expect(page).to have_content I18n.t('payment.credit_card')
      expect(page).to have_content I18n.t('payment.card_number')
      expect(page).to have_content I18n.t('payment.name_on_card')
      expect(page).to have_content I18n.t('payment.exp_month')
      expect(page).to have_content I18n.t('payment.exp_year')
      expect(page).to have_content I18n.t('payment.cvv')

      expect(page).to have_field 'order[credit_card_attributes][last4]'
      expect(page).to have_field 'order[credit_card_attributes][name]'
      expect(page).to have_field 'order[credit_card_attributes][exp_month]'
      expect(page).to have_field 'order[credit_card_attributes][exp_year]'
      expect(page).to have_field 'order[credit_card_attributes][cvv]'
    end

    scenario 'user able to fill credit card form' do
      fill_in 'order[credit_card_attributes][last4]', with: credit_card[:last4]
      fill_in 'order[credit_card_attributes][name]', with: credit_card[:name]
      fill_in 'order[credit_card_attributes][exp_month]', with: credit_card[:exp_month]
      fill_in 'order[credit_card_attributes][exp_year]', with: credit_card[:exp_year]
      fill_in 'order[credit_card_attributes][cvv]', with: 1234

      click_button(I18n.t('save_and_continue'))

      expect(page).to have_current_path('/checkout/confirm')
      expect(page).to have_content I18n.t('shipments')
    end

    scenario 'user entered wrong credit card number' do
      fill_in 'order[credit_card_attributes][last4]', with: 1

      click_button(I18n.t('save_and_continue'))

      expect(page).to have_content 'is the wrong length (should be 16 characters)'
    end
  end
end
