require 'rails_helper'

describe Books::IndexPresenter do
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

  describe '#books' do
    it 'returns collection' do
      expect(described_class.new(params).books).to be_a ActiveRecord::Relation
    end
  end

  describe '#pagy_books' do
    it 'returns pagy' do
      expect(described_class.new(params).pagy_books).to be_a Pagy
    end
  end

  describe '#sort_title' do
    let(:params) { { sort: 'title_desc' } }

    it 'returns collection' do
      expect(described_class.new(params).sort_title).to eq I18n.t('title_desc')
    end
  end

end
