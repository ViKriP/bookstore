require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  describe 'GET #index' do
    let(:category) { create(:category) }
    before { get :index }

    it { expect(response).to render_template :index }

    it 'responds with success status' do
      expect(response.status).to eq(200)
    end

    it 'assigns the book to @book' do
      expect(assigns(:book)).to eq @book
    end

    it 'assigns the presenter' do
      expect(assigns(:presenter)).to be_a BooksPresenter
    end
  end

  describe 'GET #show' do
    before do
      @book = create(:book)
      get :show, params: { id: @book }
    end

    it { expect(response).to render_template :show }

    it 'responds with success status' do
      expect(response.status).to eq(200)
    end

    it 'assigns the book to @book' do
      expect(assigns(:book)).to eq @book
    end

    it 'assigns the presenter' do
      expect(assigns(:presenter)).to be_a BookPresenter
    end
  end
end
