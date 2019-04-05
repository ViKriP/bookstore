require 'rails_helper'

RSpec.feature "Catalogs", type: :feature do
  given(:book) { create(:book) }
  given(:category) { create(:category) }

  before do
    visit category_books_path(category.id)
  end

  scenario "Page have header #{I18n.t('catalog')}" do
    expect(page).to have_content I18n.t('catalog')
  end

  scenario 'Page have link to all books' do
    expect(page).to have_selector 'a', text: I18n.t('all_books_category')
  end

  scenario 'Page have link to category' do
    expect(page).to have_selector 'a', text: category.title
  end
end
