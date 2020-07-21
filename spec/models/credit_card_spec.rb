require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  INVALID_MONTH = 13
  VALID_MONTH = (1..12)
  PAST_YEAR = 13

  it { is_expected.to belong_to(:order) }

  it { is_expected.to validate_presence_of(:last4) }
  it { is_expected.to validate_presence_of(:exp_month) }
  it { is_expected.to validate_presence_of(:exp_year) }
  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to validate_length_of(:last4).is_equal_to(16) }
  it { expect(subject).to validate_numericality_of(:exp_month).is_greater_than(0).is_less_than(13).only_integer }
  it { is_expected.to validate_length_of(:exp_year).is_equal_to(2) }
  it { is_expected.to validate_length_of(:name).is_at_most(50) }

  context 'definition of the month' do
    it { expect(subject).to_not allow_value(INVALID_MONTH).for(:exp_month) }
    it { expect(subject).to_not allow_value(1.5).for(:exp_month) }

    VALID_MONTH.each { |number|
      it { expect(subject).to allow_value(number).for(:exp_month) }
    }
  end

  context 'definition of the year' do
    let(:credit_card) { create(:credit_card) }

    it 'when wrong date' do
      expect(FactoryBot.build(:credit_card, exp_year: 'wrong')).not_to be_valid
    end

    it 'when year is invalid' do
      expect(FactoryBot.build(:credit_card, exp_year: PAST_YEAR)).not_to be_valid
    end

    it 'when year is valid' do
      expect(credit_card).to be_valid
    end
  end
end
