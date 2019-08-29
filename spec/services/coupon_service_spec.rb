require 'rails_helper'

describe CouponService do
  let(:coupon) { create(:coupon) }
  let(:order) { create(:order, discount: nil) }
  let(:service) { described_class.new(order, coupon.code) }
  let(:service_without_order) { described_class.new(nil, coupon.code) }
  let(:service_without_code) { described_class.new(order, nil) }

  describe '#coupon' do
    it 'when coupon code there is' do
      expect(service.coupon.code).to eql coupon.code
    end
  end

  describe '#use' do
    it 'when order and coupon code there are' do
      service.use

      expect(order.discount).to eql coupon.discount.to_i
    end

    it 'when is not order and coupon code there is' do
      expect(service_without_order.use).to be_nil
    end

    it 'when order there is and is not coupon code' do
      expect(service_without_code.use).to be_nil
    end
  end

  describe '#deactivate' do
    it 'when order and coupon code there are' do
      expect(service.deactivate).to eql true
    end

    it 'when is not coupon code' do
      expect(service_without_code.use).to be_nil
    end
  end
end
