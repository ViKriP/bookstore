require 'rails_helper'

RSpec.describe Admin::AuthorsController, type: :controller do
  render_views
  let(:page) { Capybara::Node::Simple.new(response.body) }
  let(:admin_user) { create(:admin_user) }
  let(:author) { create(:author) }
  before { sign_in admin_user }

  describe 'GET index' do
    it "should render the expected columns" do
      author.save
      get :index
      expect(page).to have_content('First Name')
      expect(page).to have_content('Last Name')
      expect(page).to have_content('Description')
    end
  end    

  describe "GET new" do
    it "should render the form elements" do
      get :new
      expect(page).to have_field('First name*')
      expect(page).to have_field('Last name*')
      expect(page).to have_field('Description')
    end
  end
end