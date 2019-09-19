require 'rails_helper'

describe OrdersCleanerService do
  describe '#call' do
    let(:guest_order_bad) { create(:order, user_id: nil, created_at: 1.day.ago) }

    let(:service) { described_class.new }

    context 'When guest order is outdated' do
      it 'outdated order is deleted' do
        allow(Order).to receive(:create).and_return(guest_order_bad)

        service.call

        expect(Order.find_by_id(guest_order_bad)).to be_nil
      end
    end
  end
end
