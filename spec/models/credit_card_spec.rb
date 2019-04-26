require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  OUTDATED_EXP_DATE = '01/11'
  INVALID_MONTH_EXP_DATE = '13/20'

  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:number) }
  it { is_expected.to validate_presence_of(:exp_date) }
  it { is_expected.to validate_presence_of(:cvv) }
  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to validate_length_of(:number).is_equal_to(16) }
  it { is_expected.to validate_length_of(:cvv).is_at_least(3).is_at_most(4) }
  it { is_expected.to validate_length_of(:name).is_at_most(50) }

  context 'when expiration date is outdated' do
    let(:credit_card) { create(:credit_card, :skip_validate, exp_date: OUTDATED_EXP_DATE) }

    it 'is invalid' do
      expect(credit_card).not_to be_valid
      expect(credit_card.errors.messages[:exp_date]).to include("can't be in the past")
    end
  end

  context 'when expiration date month is out of range' do
    let(:credit_card) { create(:credit_card, :skip_validate, exp_date: INVALID_MONTH_EXP_DATE) }

    it 'is invalid' do
      expect(credit_card).not_to be_valid
      expect(credit_card.errors.messages[:exp_date]).to include('month invalid')
    end
  end

  context 'when expiration date is valid' do
    let(:credit_card) { create(:credit_card) }

    it 'is valid' do
      expect(credit_card).to be_valid
    end
  end
end
