require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  let(:order_item) { create(:order_item) }

  it { is_expected.to belong_to(:order) }
  it { is_expected.to belong_to(:book) }

  it { is_expected.to validate_presence_of(:book_id) }

  it { is_expected.to validate_presence_of(:order_id) }

  it { is_expected.to validate_presence_of(:quantity) }

  it do
    is_expected.to validate_numericality_of(:quantity).is_greater_than(0)
    is_expected.to validate_numericality_of(:quantity).only_integer
  end
end
