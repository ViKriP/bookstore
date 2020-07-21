require 'rails_helper'

RSpec.describe Admin::DeliveriesController, type: :controller do
  render_views
  let(:page) { Capybara::Node::Simple.new(response.body) }
  let(:admin_user) { create(:admin_user) }
  let(:delivery) { create(:delivery) }
  before { sign_in admin_user }

  describe 'GET index' do
    it "should render the expected columns" do
      delivery.save
      get :index
      expect(page).to have_content('Name')
      expect(page).to have_content('Period')
      expect(page).to have_content('Price')
    end
  end    

  describe "GET new" do
    it "should render the form elements" do
      get :new
      expect(page).to have_field('Name*')
      expect(page).to have_field('Period*')
      expect(page).to have_field('Price*')
    end
  end
end
