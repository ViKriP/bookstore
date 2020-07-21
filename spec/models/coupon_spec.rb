require 'rails_helper'

RSpec.describe Coupon, type: :model do
  it { is_expected.to validate_presence_of(:code) }
  it { is_expected.to validate_presence_of(:discount) }
  it { is_expected.to validate_numericality_of(:discount).is_greater_than_or_equal_to(1) }
end
