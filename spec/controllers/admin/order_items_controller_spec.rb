require 'rails_helper'

RSpec.describe Admin::OrderItemsController, type: :controller do
  render_views

  let(:page) { Capybara::Node::Simple.new(response.body) }
  let(:admin_user) { create(:admin_user) }
  let(:order_item) { create(:order_item) }

  before { sign_in admin_user }

  describe 'GET index' do
    it "should render the expected columns" do
      order_item.save
      get :index
      expect(page).to have_content('Quantity')
      expect(page).to have_content('Order')
      expect(page).to have_content('Book')
    end
  end
end
