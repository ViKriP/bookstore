require 'rails_helper'

RSpec.describe GuestOrder, type: :model do
  it { is_expected.to belong_to(:order) }
end
