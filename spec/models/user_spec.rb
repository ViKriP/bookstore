require 'rails_helper'
require 'cancan/matchers'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:reviews).dependent(:destroy) }
  it { is_expected.to have_one(:billing_address).dependent(:destroy) }
  it { is_expected.to have_one(:shipping_address).dependent(:destroy) }
  it { is_expected.to have_many(:orders) }

  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }

  it { is_expected.to validate_length_of(:first_name).is_at_most(50) }
  it { is_expected.to validate_length_of(:last_name).is_at_most(50) }

  describe 'abilities' do
    let(:user) { create(:user) }
    subject(:ability) { Ability.new(user) }
    let(:book) { create(:book) }
    let(:order) { create(:order, user: user) }
    let(:review) { create(:review, user: user) }

    it { is_expected.to be_able_to(:read, review) }
    it { is_expected.to be_able_to(:manage, user) }
    it { is_expected.to be_able_to(:create, review) }
    it { is_expected.to be_able_to(:read, review) }
  end
end
