require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:book) { create(:book) }

    before do
      sign_in user
      allow(controller).to receive(:current_user).and_return(user)
    end

    context 'when invalid data' do
      let(:invalid_post_action) { post :create, params: {
        book_id: book.id, review: attributes_for(:review, rating: nil, book_id: book.id) }
      }

      before { invalid_post_action }

      it 'does not save review' do
        expect{ invalid_post_action }.not_to change(Review, :count)
      end

      it 'redirects to book' do
        expect(response).to redirect_to book
      end

      it 'sends alert notice' do
        expect(flash[:alert]).to eq I18n.t('review_error')
      end
    end

    context 'when valid data' do
      let(:valid_post_action) { post :create, params: {
        book_id: book.id, review: attributes_for(:review, book_id: book.id) }
      }

      it 'saves review' do
        expect{ valid_post_action }.to change(Review, :count).by(1)
      end

      it 'sends success notice' do
        valid_post_action
        expect(flash[:notice]).to eq I18n.t('review_success')
      end
    end
  end
end
