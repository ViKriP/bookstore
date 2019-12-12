require 'rails_helper'

RSpec.feature "RootPages", type: :feature do
  before do
    visit root_path
  end

  scenario 'Have slider' do
    expect(page).to have_selector '#slider'
  end

  scenario 'Have welcome block' do
    expect(page).to have_content I18n.t('welcome')
  end

  scenario 'Have best sellers block' do
    expect(page).to have_content I18n.t('best_sellers')
  end

  scenario 'Click on logo redirects to root path' do
    click_link(I18n.t('site_name'))

    expect(page).to have_current_path root_path
  end

  scenario "Click on #{I18n.t('home')} redirects to root path" do
    find('#navbar').find('.hidden-xs').click_link(I18n.t('home'))

    expect(page).to have_current_path root_path
  end

  scenario "Click on #{I18n.t('login')} redirects to new session path" do
    find('#navbar').find('.hidden-xs').click_link(I18n.t('login'))

    expect(page).to have_current_path new_user_session_path
  end

  scenario "Click on #{I18n.t('signup')} redirects to new user refistration path" do
    find('#navbar').find('.hidden-xs').click_link(I18n.t('signup'))

    expect(page).to have_current_path new_user_registration_path
  end

  scenario "Click on #{I18n.t('get_started')} button redirects to books path" do
    click_link(I18n.t('get_started'))

    expect(page).to have_current_path books_path
  end
end
