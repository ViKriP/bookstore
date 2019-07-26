require 'rails_helper'

describe BooksPresenter do
  let(:category) { create(:category) }
  let(:params) { { category_id: category.id } }
  let(:params_title_asc) { { sort: 'title_asc' } }
  let(:params_title_desc) { { sort: 'title_desc' } }
  let(:params_price_asc) { { sort: 'price_asc' } }
  let(:params_price_desc) { { sort: 'price_desc' } }
  let(:params_date_asc) { { sort: 'date_asc' } }
  let(:params_popular) { { sort: 'popular' } }
  let(:params_wrong) { { sort: 'wrong' } }

  describe '#categories' do
    it 'returns collection' do
      expect(described_class.new(params).categories).to be_a ActiveRecord::Relation
    end
  end

  describe '#category' do
    it 'returns category' do
      expect(described_class.new(params).category.title).to eq 'Web development'
    end

    it 'when no category' do
      expect(described_class.new(params).category.title).not_to eq 'Wrong category'
    end
  end

  describe '#sort_title' do
    BooksPresenter::SORT_TITLES.each do |phrase|
      it '' do
        expect(described_class.new(send("params_#{phrase[0]}")).sort_title).to be(phrase[1])
      end
    end

    it 'should returns default if wrong param' do
      expect(described_class.new(params_wrong).sort_title).to be(BooksPresenter::SORT_TITLES[:title_asc])
    end
  end
end
