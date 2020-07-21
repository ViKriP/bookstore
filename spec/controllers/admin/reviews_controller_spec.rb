require 'rails_helper'

RSpec.describe Admin::ReviewsController, type: :controller do
  render_views
  let(:page) { Capybara::Node::Simple.new(response.body) }
  let(:admin_user) { create(:admin_user) }
  let(:review) { create(:review) }
  before { sign_in admin_user }

  describe 'GET index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'should render the form elements' do
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

    it 'should render the form elements' do
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

  describe 'GET show' do
    before do
      get :show, params: { id: review.id }
    end

    it 'should render the form elements' do
      expect(page).to have_content(I18n.t('user'))
      expect(page).to have_content(I18n.t('book'))
      expect(page).to have_content(I18n.t('title'))
      expect(page).to have_content(I18n.t('comment'))
      expect(page).to have_content(I18n.t('approved'))
    end
  end

  describe 'Member action approve' do
    before(:each) do
      patch :approve, params: { id: review.id }
    end

    it "when isn't approved" do 
      review.approved = false
      review.save
      get :index
      expect(page).to have_content('Approved')
    end
  end

  describe 'Batch action approve' do
    before(:each) do
      patch :approve, params: { id: review.id }
    end

    it "when is approving" do 
      review.approved = false
      review.save

      post :batch_action, params: { batch_action: 'approve', collection_selection_toggle_all: 'on', collection_selection: [review.id] }
      review.reload
      expect(review.approved).to eq true
    end
  end
end
