require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do
  let(:order_item) { create(:order_item) }
  let(:order_item_params) { attributes_for(:order_item).stringify_keys }
  let(:order) { create(:order) }
  let(:book) { create(:book) }

  before do
    allow(controller).to receive(:current_user_order).and_return(order)
  end

  describe "POST #create" do
    before do
      request.env['HTTP_REFERER'] = root_url
    end

    let(:valid_post_action) { post :create, params: { order_item: { quantity: 5, book_id: book.id } } }
    let(:invalid_post_action) { post :create, params: { order_item: { quantity: 5 } } }

    context 'with valid params' do
      it 'saves order item' do
        expect{ valid_post_action }.to change(OrderItem, :count).by(1)
      end

      it 'sends success notice' do
        valid_post_action
        expect(flash[:notice]).to eq I18n.t('item_added')
      end
    end

    context 'with invalid params' do
      it 'not saves order item' do
        expect{ invalid_post_action }.not_to change(OrderItem, :count)
      end

      it 'sends error alert' do
        invalid_post_action
        expect(flash[:alert]).to eq I18n.t('error')
      end
    end
  end

  describe 'PATCH #update' do
    before do
      allow(order).to receive_message_chain(:order_items, :find).and_return(order_item)
      patch :update, params: { id: order_item.id, order_item: order_item_params }
    end

    let(:order_item_params_error) { { quantity: '0' } }
    let(:invalid_patch) { patch :update, params: { id: order_item.id, order_item: order_item_params_error } }

    it 'assigns order item to @order_item' do
      expect(assigns(:order_item)).to eq(order_item)
    end

    it 'redirects to cart' do
      expect(response).to redirect_to cart_path
    end

    it 'sends success notice' do
      expect(flash[:notice]).to eq I18n.t('item_updated')
    end

    it 'sends error alert' do
      invalid_patch
      expect(flash[:alert]).to eq I18n.t('error')
    end
  end

  describe 'DELETE #destroy' do
    before { allow(controller).to receive(:current_user_order).and_return(order_item.order) }

    let(:destroy_action) { delete :destroy, params: { id: order_item.id, order_item: order_item_params } }
    
    it 'removes order item' do
      expect{ destroy_action }.to change(OrderItem, :count).by(-1)
    end

    it 'redirects to cart' do
      destroy_action
      expect(response).to redirect_to cart_path
    end

    it 'sends success notice' do
      destroy_action
      expect(flash[:notice]).to eq I18n.t('item_removed')
    end
  end
end
