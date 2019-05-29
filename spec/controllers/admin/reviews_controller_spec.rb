require 'rails_helper'

RSpec.describe Admin::ReviewsController, type: :controller do
  render_views
  let(:page) { Capybara::Node::Simple.new(response.body) }
  let(:admin_user) { create(:admin_user) }
  let(:review) { create(:review) }
  before { sign_in admin_user }

  describe "GET index" do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "should render the form elements" do
      review
      get :index
      expect(page).to have_content(I18n.t('book'))
      expect(page).to have_content(I18n.t('title'))
      expect(page).to have_content(I18n.t('comment'))
      expect(page).to have_content(I18n.t('admin.date'))
      expect(page).to have_content(I18n.t('user'))
      expect(page).to have_content(I18n.t('approved'))
      expect(page).to have_content(I18n.t('admin.show'))
    end

    it "should render the form elements" do
      review.approved = false
      review.save
      get :index
      expect(page).to have_content(I18n.t('book'))
      expect(page).to have_content(I18n.t('title'))
      expect(page).to have_content(I18n.t('comment'))
      expect(page).to have_content(I18n.t('admin.date'))
      expect(page).to have_content(I18n.t('user'))
      expect(page).to have_content(I18n.t('approved'))
      expect(page).to have_content(I18n.t('admin.show'))
      expect(page).to have_content(I18n.t('admin.approve'))
    end
  end

  describe "GET show" do
    before do
      get :show, params: { id: review.id }
    end

    it "should render the form elements" do
      expect(page).to have_content(I18n.t('user'))
      expect(page).to have_content(I18n.t('book'))
      expect(page).to have_content(I18n.t('title'))
      expect(page).to have_content(I18n.t('comment'))
      expect(page).to have_content(I18n.t('approved'))
    end
  end
end
