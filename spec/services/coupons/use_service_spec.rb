require 'rails_helper'

describe Coupons::UseService do
  let(:coupon) { create(:coupon) }
  let(:order) { create(:order, discount: nil) }

  describe '#call' do
    context 'When used successfully' do
      it 'when order there is' do
        described_class.new(order, coupon).call

        expect(order.discount).to eql coupon.discount.to_i
        expect(coupon.active).to eql false
      end
    end

    context "When used isn't successfully" do
      it 'when is not order' do
        described_class.new(nil, coupon).call

        expect(order.discount).to be_nil
        expect(coupon.active).to eql true
      end

      it 'when is not coupon' do
        described_class.new(order, nil).call

        expect(order.discount).to be_nil
        expect(coupon.active).to eql true
      end
    end
  end
end
