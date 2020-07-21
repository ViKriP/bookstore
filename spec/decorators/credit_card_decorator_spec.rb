require 'rails_helper'

RSpec.describe CreditCardDecorator do
  let(:credit_card) { build_stubbed(:credit_card).decorate }

  describe '#secure_card_number' do
    it 'shows only last four numbers and hides others' do
      expect(credit_card.secure_card_number).to eq("** ** ** #{credit_card.last4.last(4)}")
    end
  end

  describe '#exp_date' do
    it 'shows together month and year' do
      expect(credit_card.exp_date).to eq('12 / 25')
    end
  end
end
