require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  describe 'GET #index' do
    let(:category) { create(:category) }
    let!(:book_category) { create(:book_category, category: category) }
    let(:param) { { sort: nil, category_id:  category.id } }

    before { get :index, params: param }

    it { expect(response).to render_template :index }

    it 'responds with success status' do
      expect(response.status).to eq(200)
    end

    it 'assigns the books to @books' do
      sorted_books = BookSortingService.new(param, @books).call

      expect(assigns(:books).first.title).to eql(sorted_books.first.title)
    end

    it 'assigns the pages to @pagy' do
      expect(assigns(:pagy)).to be_a(Pagy)
    end

    it 'assigns the presenter' do
      cat = BooksPresenter.new(param).category

      expect(assigns(:presenter).category.title).to eql(cat.title)
    end
  end

  describe 'GET #show' do
    let(:book) { create(:book) }
    let!(:review) { create(:review, book: book) }

    before do
      get :show, params: { id: book.id }
    end

    it { expect(response).to render_template :show }

    it 'responds with success status' do
      expect(response.status).to eq(200)
    end

    it 'assigns the book to @book' do
      expect(assigns(:book).title).to eq(book.title)
    end

    it 'assigns the presenter' do
      expect(assigns(:presenter).reviews.first.title).to eql(review.title)
    end
  end
end
