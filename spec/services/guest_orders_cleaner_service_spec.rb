require 'rails_helper'

describe GuestOrdersCleanerService do
  let(:current_user) { create(:user) }
  let(:guest_orders) { create(:guest_orders) }
  let(:guest_session_id) { '91674c338189b80bc6a5d09e2c459ca6' }

  describe '#call' do
    #let(:subject) { described_class.new(current_user, guest_session_id) }

    context "when guest_order there is" do
      it do
        service = described_class.new(current_user, guest_session_id)
        expect(service).to receive(:cleaning_guest_order)
        #expect(service).to receive(:cleaning_time)
        service.call
      end
    end
  end
end
