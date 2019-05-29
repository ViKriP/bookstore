require 'rails_helper'

RSpec.describe Admin::BooksController, type: :controller do
  render_views
  let(:page) { Capybara::Node::Simple.new(response.body) }
  let(:admin_user) { create(:admin_user) }
  before { sign_in admin_user }

  describe "GET new" do
    it "should render the form elements" do
      get :new
      expect(page).to have_field('Title*')
      expect(page).to have_field('Price*')
      expect(page).to have_field('Quantity*')
      expect(page).to have_field('Year')
      expect(page).to have_field('Description*')
      expect(page).to have_field('Materials')
      expect(page).to have_field('Height')
      expect(page).to have_field('Width')
      expect(page).to have_field('Depth')
      expect(page).to have_field('Categories')
      expect(page).to have_field('Authors')
      expect(page).to have_css('#book_images')
    end
  end
end
