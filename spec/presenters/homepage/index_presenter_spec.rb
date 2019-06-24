require 'rails_helper'

describe Homepage::IndexPresenter do
  describe '#last_books' do
    it 'returns collection' do
      expect(described_class.new.last_books).to be_a Array
    end
  end

  describe '#best_sellers' do
    it 'returns collection' do
      expect(described_class.new.best_sellers).to be_a ActiveRecord::Relation
    end
  end
end
