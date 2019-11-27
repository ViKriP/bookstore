require 'rails_helper'

feature 'Checkout' do
  given(:order) { create(:order) }
  given(:user) { order.user }
  given(:user_with_billing) { create(:user, :with_addresses) }
  given(:billing_address_attributes) { attributes_for(:billing_address) }
  given(:shipping_address_attributes) { attributes_for(:shipping_address) }

  before do
    create(:book, :have_long_description_author)
  end

  context 'Addresses' do
    context 'when user have no addresses yet' do
      before do
        login_as(user, scope: :user)
        visit root_path
        click_button(I18n.t('buy_now'))
        visit cart_path
        click_button(I18n.t('checkout'), match: :first)
      end

      scenario 'user redirected to address page' do
        expect(page).to have_content I18n.t('checkout')
        expect(page).to have_content I18n.t('billing_address')
        expect(page).to have_content I18n.t('shipping_address')
      end

      scenario 'user able to fill address forms' do
        fill_in 'order[billing_address_attributes][first_name]', with: billing_address_attributes[:first_name]
        fill_in 'order[billing_address_attributes][last_name]', with: billing_address_attributes[:last_name]
        fill_in 'order[billing_address_attributes][address]', with: billing_address_attributes[:address]
        fill_in 'order[billing_address_attributes][city]', with: billing_address_attributes[:city]
        fill_in 'order[billing_address_attributes][zip]', with: billing_address_attributes[:zip]
        select 'Ukraine', from: 'order[billing_address_attributes][country]'
        fill_in 'order[billing_address_attributes][phone]', with: billing_address_attributes[:phone]
        fill_in 'order[shipping_address_attributes][first_name]', with: shipping_address_attributes[:first_name]
        fill_in 'order[shipping_address_attributes][last_name]', with: shipping_address_attributes[:last_name]
        fill_in 'order[shipping_address_attributes][address]', with: shipping_address_attributes[:address]
        fill_in 'order[shipping_address_attributes][city]', with: shipping_address_attributes[:city]
        fill_in 'order[shipping_address_attributes][zip]', with: shipping_address_attributes[:zip]
        select 'Ukraine', from: 'order[shipping_address_attributes][country]'
        fill_in 'order[shipping_address_attributes][phone]', with: shipping_address_attributes[:phone]

        click_button(I18n.t('save_and_continue'))

        expect(page).not_to have_content I18n.t('billing_address')
        expect(page).not_to have_content I18n.t('shipping_address')
        expect(page).to have_content I18n.t('delivery.method')
      end

      context 'when form incorrectly filled' do
        scenario 'Shows error message' do
          visit cart_path
          click_button(I18n.t('checkout'), match: :first)
          fill_in 'order[shipping_address_attributes][first_name]', with: ''
          click_button(I18n.t('save_and_continue'))
          expect(page).to have_content "can't be blank"
        end
      end
    end

    context 'when user already have billing address' do
      before do
        login_as(user_with_billing, scope: :user)
        visit root_path
        click_button(I18n.t('buy_now'))
        visit cart_path
        click_button(I18n.t('checkout'), match: :first)
      end
 
      scenario 'Form already filled with user address' do
        expect(page).to have_field 'order[billing_address_attributes][first_name]', with: user_with_billing.billing_address.first_name
        expect(page).to have_field 'order[billing_address_attributes][last_name]', with: user_with_billing.billing_address.last_name
        expect(page).to have_field 'order[billing_address_attributes][address]', with: user_with_billing.billing_address.address
        expect(page).to have_field 'order[billing_address_attributes][city]', with: user_with_billing.billing_address.city
        expect(page).to have_field 'order[billing_address_attributes][zip]', with: user_with_billing.billing_address.zip
        expect(page).to have_field 'order[billing_address_attributes][country]', with: user_with_billing.billing_address.country
        expect(page).to have_field 'order[billing_address_attributes][phone]', with: user_with_billing.billing_address.phone
      end
    end

    context 'when user wants to use billing address as shipping' do
      scenario 'Shipping address not raises errors and filled with billing data' do
        login_as(user, scope: :user)
        visit root_path
        click_button(I18n.t('buy_now'))
        visit cart_path
        click_button(I18n.t('checkout'), match: :first)

        fill_in 'order[billing_address_attributes][first_name]', with: billing_address_attributes[:first_name]
        fill_in 'order[billing_address_attributes][last_name]', with: billing_address_attributes[:last_name]
        fill_in 'order[billing_address_attributes][address]', with: billing_address_attributes[:address]
        fill_in 'order[billing_address_attributes][city]', with: billing_address_attributes[:city]
        fill_in 'order[billing_address_attributes][zip]', with: billing_address_attributes[:zip]
        select 'Ukraine', from: 'order[billing_address_attributes][country]'
        fill_in 'order[billing_address_attributes][phone]', with: billing_address_attributes[:phone]

        page.check(I18n.t('use_billing'))
        click_button(I18n.t('save_and_continue'))

        expect(page).not_to have_content I18n.t('billing_address')
        expect(page).not_to have_content I18n.t('shipping_address')
        expect(page).to have_content I18n.t('delivery.method')
      end
    end
  end
end