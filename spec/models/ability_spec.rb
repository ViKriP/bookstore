require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do
  describe 'abilities' do
    context 'when authorized user' do
      let(:user) { create(:user) }
      subject(:ability) { Ability.new(user) }

      %i[create read update destroy].each do |role|
        it { expect(subject).to be_able_to(role, User) }
      end

      %i[create read].each do |role|
        it { expect(subject).to be_able_to(role, Review) }
      end

      %i[read update].each do |role|
        it { expect(subject).to be_able_to(role, Order) }
      end

      %i[read].each do |role|
        it { expect(subject).to be_able_to(role, Book) }
      end

      %i[create read update destroy].each do |role|
        it { expect(subject).to be_able_to(role, OrderItem) }
      end

      it { is_expected.to be_able_to(:read, :all) }

      it { expect(subject).not_to be_able_to(:destroy, Order) }
      it { expect(subject).not_to be_able_to(:destroy, Review) }
      it { expect(subject).not_to be_able_to(:destroy, Book) }
    end

    context 'when not authorized user' do
      let(:user) { nil }
      subject(:ability) { Ability.new(user) }

      it { is_expected.to be_able_to(:read, Book.new) }
      it { is_expected.to be_able_to(:read, Review.new(user: user)) }
      it { is_expected.to be_able_to(:update, Order.new(user: user)) }

      %i[create read update destroy].each do |role|
        it { expect(subject).to be_able_to(role, OrderItem) }
      end

      it { is_expected.not_to be_able_to(:create, Review.new(user: user)) }
    end
  end
end
