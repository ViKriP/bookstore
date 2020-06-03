require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { create(:order) }
  let(:order_item) { create(:order_item) }

  before { allow(order).to receive(:order_items).and_return([order_item]) }

  it { is_expected.to have_many(:order_items).dependent(:destroy) }
  it { is_expected.to have_one(:billing_address).dependent(:destroy) }
  it { is_expected.to have_one(:shipping_address).dependent(:destroy) }
  it { is_expected.to have_one(:credit_card).dependent(:destroy) }
  it { is_expected.to belong_to(:user).optional }
  it { is_expected.to belong_to(:delivery).optional }
end
