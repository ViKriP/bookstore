require 'rails_helper'

RSpec.describe AuthorDecorator do
  let(:author) { build_stubbed(:author).decorate }

  describe '#name' do
    it 'returns author name' do
      expect(author.name).to eq("#{author.first_name} #{author.last_name}")
    end
  end
end
