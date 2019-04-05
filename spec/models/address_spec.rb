require 'rails_helper'

RSpec.describe Address, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  let(:address) { create(:address) }

  #it { should belong_to(:addressable) }

  context 'validations' do
    %i[first_name last_name address city zip country phone].each do |column|
      it do
        should validate_presence_of(column)
      end
    end

    %i[first_name last_name address].each do |column|
      it { should validate_length_of(column).is_at_most(50).with_long_message('50 characters only') }
    end

    it { should validate_length_of(:phone).is_at_most(15) }
    it { should validate_length_of(:zip).is_at_most(10) }
  end

  describe '#country_name' do
    it 'returns full country name' do
      expect(address.country).to eq 'Ukraine'
    end
  end
end
