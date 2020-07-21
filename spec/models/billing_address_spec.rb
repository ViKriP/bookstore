require 'rails_helper'

RSpec.describe BillingAddress, type: :model do
  it { expect(described_class).to be < Address }
end