require 'rails_helper'

describe CartPresenter do
  let(:coupon) { create(:coupon) }

  describe '#coupon' do
    it 'when coupon there is' do
      expect(described_class.new(coupon.code).coupon).to be_a Coupon
    end
  end
end
