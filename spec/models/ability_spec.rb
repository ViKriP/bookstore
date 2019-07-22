require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do
  describe 'abilities' do
    let(:user) { create(:user) }
    subject(:ability) { Ability.new(user) }

    it { is_expected.to be_able_to(:create, Review.new(user: user)) }
    it { is_expected.to be_able_to(:read, :all) }
  end
end
