require 'rails_helper'

RSpec.describe Admin::OrdersController, type: :controller do
  render_views
  let(:page) { Capybara::Node::Simple.new(response.body) }
  let(:admin_user) { create(:admin_user) }
  let(:order) { create(:order) }
  let(:order_item) { create(:order_item) }
  before { sign_in admin_user }

  describe "GET index" do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "should render the form elements" do
      order
      get :index
      expect(page).to have_content(I18n.t('id'))
      expect(page).to have_content(I18n.t('admin.date'))
      expect(page).to have_content(I18n.t('admin.state'))
      expect(page).to have_content(I18n.t('admin.show'))
    end
  end

  describe "GET show" do
    before do
      order_item
      get :show, params: { id: order_item.order.id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it "should render the form elements" do
      expect(page).to have_content(order_item.order.user.email)
      expect(page).to have_content(I18n.t('admin.order_items'))
      expect(page).to have_content("#{order_item.book.title} (#{order_item.quantity})")
    end
  end

  describe "GET edit" do
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it "should render the form elements for state in queue" do
      order.state = 'in_queue'
      order.save
      get :edit, params: { id: order.id }
      expect(page).to have_content(I18n.t('admin.state'))
      expect(page).to have_content(I18n.t('form.in_delivery'))
      expect(page).to have_content(I18n.t('form.canceled'))
    end

    it "should render the form elements for state in delivery" do
      order.state = 'in_delivery'
      order.save
      get :edit, params: { id: order.id }
      expect(page).to have_content(I18n.t('admin.state'))
      expect(page).to have_content(I18n.t('form.delivered'))
      expect(page).to have_content(I18n.t('form.canceled'))
    end
  end
end
