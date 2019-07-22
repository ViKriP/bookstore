require 'rails_helper'

RSpec.describe Admin::CouponsController, type: :controller do
  render_views
  let(:page) { Capybara::Node::Simple.new(response.body) }
  let(:admin_user) { create(:admin_user) }
  let(:coupon) { create(:coupon) }
  before { sign_in admin_user }

  describe 'GET index' do
    it "should render the expected columns" do
      coupon.save
      get :index
      expect(page).to have_content('Code')
      expect(page).to have_content('Discount')
      expect(page).to have_content('Active')
    end
  end    

  describe "GET new" do
    it "should render the form elements" do
      get :new
      expect(page).to have_field('Code*')
      expect(page).to have_field('Discount*')
      expect(page).to have_field('Active')
    end
  end
end
