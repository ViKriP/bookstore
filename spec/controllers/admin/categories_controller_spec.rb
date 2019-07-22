require 'rails_helper'

RSpec.describe Admin::CategoriesController, type: :controller do
  render_views
  let(:page) { Capybara::Node::Simple.new(response.body) }
  let(:admin_user) { create(:admin_user) }
  let(:category) { create(:category) }
  before { sign_in admin_user }

  describe 'GET index' do
    it "should render the expected columns" do
        category.save
      get :index
      expect(page).to have_content('Title')
    end
  end    

  describe "GET new" do
    it "should render the form elements" do
      get :new
      expect(page).to have_field('Title*')
    end
  end
end