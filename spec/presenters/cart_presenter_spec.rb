require 'rails_helper'

describe CartPresenter do
  let(:coupon) { create(:coupon) }
  let(:order) { create(:order) }

  describe '#coupon' do
    it 'when coupon there is' do
      expect(described_class.new(order, coupon.code).coupon).to be_a Coupon
    end
  end

  describe '#deactivate_coupon' do
    it 'when diactivate coupon is successfully' do
      expect(described_class.new(order, coupon.code).deactivate_coupon).to be true
    end
  end

  describe '#update_order' do
    it 'when update oreder is successfully' do
      expect(described_class.new(order, coupon.code).update_order).to be true
    end
  end
end
