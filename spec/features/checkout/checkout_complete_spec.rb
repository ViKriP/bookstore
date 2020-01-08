require 'rails_helper'

feature 'Checkout' do
  given(:user) { create(:user, :with_addresses) }
  given(:book) { create(:book, :long_description) }
  given(:delivery) { create(:delivery) }
  given(:order) { create(:order) }
  given(:credit_card) { attributes_for(:credit_card) }

  context 'Complete' do
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
      click_link(I18n.t('place_order'))
    end

    scenario 'user redirected to complete page' do
      expect(page).to have_current_path('/checkout/complete')
      expect(page).to have_content I18n.t('complete.thank_you')
      expect(page).to have_content I18n.t('complete.info_sent_to', email: user.email)

      expect(page).to have_content order.number
      expect(page).to have_content book.title
    end

    scenario 'user redirected to catalog page' do
      click_link(I18n.t('back_to_store'))

      expect(page).to have_current_path(books_path)
    end
  end
end
