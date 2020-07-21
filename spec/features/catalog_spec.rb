require 'rails_helper'

RSpec.feature "Catalogs", type: :feature do
  given(:books) { create_list(:book, 4) }
  given(:category) { create(:category) }
  given(:category_2) { create(:category) }

  background do
    books
    create(:book_category, category: category, book: books[0])
    create(:book_category, category: category, book: books[1])
  end

  scenario "Page have header #{I18n.t('catalog')}" do
    visit category_books_path(category.id)

    expect(page).to have_content I18n.t('catalog')
  end

  scenario 'Page have link to all books' do
    visit category_books_path(category.id)

    expect(page).to have_selector 'a', text: I18n.t('all_books_category')
  end

  scenario 'Page have link to category' do
    visit category_books_path(category.id)

    expect(page).to have_selector 'a', text: category.title
  end

  scenario 'Go to catalog from menu' do
    visit root_path

    within('div.hidden-xs') do
      find('.nav.navbar-nav').click_link(I18n.t('menu.item.shop'))
      find('ul.dropdown-menu').all('a').first.click
    end

    expect(page.current_path).to eq category_books_path(category.id)
  end

  scenario 'Sorting of books' do
    visit books_path

    within('div.dropdown.width-240') do
      find('a.dropdown-toggle.lead.small').click
      find('ul.dropdown-menu').click_link(I18n.t('category.filter.title_asc'))
    end

    expect(page.current_path).to eq books_path

    expect(all('.title').first.text).to eq books.sort_by(&:title).first.title.truncate(20)

    within('div.dropdown.width-240') do
      find('a.dropdown-toggle.lead.small').click
      find('ul.dropdown-menu').click_link(I18n.t('category.filter.title_desc'))
    end

    expect(all('.title').first.text).to eq books.sort_by(&:title).reverse.first.title.truncate(20)
  end

  scenario 'Changing a category' do
    visit category_books_path(category.id)

    find('ul.list-inline.pt-10.mb-25.mr-240').click_link(category.title)
    expect(page.current_path).to eq category_books_path(category.id)

    visit category_books_path(category_2.id)

    find('ul.list-inline.pt-10.mb-25.mr-240').click_link(category_2.title)
    expect(page.current_path).to eq category_books_path(category_2.id)
  end

  scenario 'When book is displayed on page' do
    visit category_books_path(category.id)

    expect(page).to have_content(books[0].title.truncate(20))
  end

  scenario 'List books of category' do
    visit category_books_path(category.id)

    quantity_book = find('ul.list-inline.pt-10.mb-25.mr-240').find_link(category.title, href: category_books_path(category.id)).find('span').text

    expect(quantity_book).to eq '2'
  end
end
