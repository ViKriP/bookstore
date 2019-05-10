require 'rails_helper'

RSpec.describe ShippingAddress, type: :model do
  it { expect(described_class).to be < Address }
end