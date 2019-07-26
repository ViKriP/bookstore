require 'rails_helper'

describe BooksPresenter do
  let(:category) { create(:category) }
  let(:params) { { category_id: category.id } }

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
end
