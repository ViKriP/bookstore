require 'rails_helper'

RSpec.describe CreditCardDecorator do
    let(:credit_card) { build_stubbed(:credit_card).decorate }

  describe '#secure_card_number' do
    it 'shows only last four numbers and hides others' do
      expect(credit_card.secure_card_number).to eq(credit_card.number.last(4))
    end
  end
end
