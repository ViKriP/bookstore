require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  INVALID_MONTH = '13'
  VALID_MONTH = '12'
  PAST_YEAR = '13'

  it { is_expected.to belong_to(:order) }

  it { is_expected.to validate_presence_of(:last4) }
  it { is_expected.to validate_presence_of(:exp_month) }
  it { is_expected.to validate_presence_of(:exp_year) }
  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to validate_length_of(:last4).is_equal_to(16) }
  it { is_expected.to validate_length_of(:exp_month).is_at_least(1).is_at_most(2) }
  it { is_expected.to validate_length_of(:exp_year).is_equal_to(2) }
  it { is_expected.to validate_length_of(:name).is_at_most(50) }

  context 'when expiration date is outdated' do
    let(:credit_card) { create(:credit_card, :skip_validate, exp_month: VALID_MONTH) }
    let(:credit_card) { create(:credit_card, :skip_validate, exp_year: PAST_YEAR) }

    it 'is invalid' do
      expect(credit_card).not_to be_valid
      expect(credit_card.errors.messages[:exp_year]).to include("can't be in the past")
    end
  end

  context 'when expiration date month is out of range' do
    let(:credit_card) { create(:credit_card, :skip_validate, exp_year: PAST_YEAR) }
    let(:credit_card) { create(:credit_card, :skip_validate, exp_month: INVALID_MONTH) }

    it 'is invalid' do
      expect(credit_card).not_to be_valid
      expect(credit_card.errors.messages[:exp_year]).to include('date invalid')
    end
  end

  context 'when expiration date is valid' do
    let(:credit_card) { create(:credit_card) }

    it 'is valid' do
      expect(credit_card).to be_valid
    end
  end
end
