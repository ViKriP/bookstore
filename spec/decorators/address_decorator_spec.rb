require 'rails_helper'

describe AddressDecorator do
  let(:address) { build_stubbed(:address).decorate }

  describe '#full_name' do
    it 'combines first and last name' do
      expect(address.full_name).to eq("#{address.first_name} #{address.last_name}")
    end
  end
end
