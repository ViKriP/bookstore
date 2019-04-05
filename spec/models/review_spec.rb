require 'rails_helper'

RSpec.describe Review, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:book) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:comment) }
  it { is_expected.to validate_presence_of(:rating) }

  it { is_expected.to validate_length_of(:title).is_at_most(80) }
  it { is_expected.to validate_length_of(:comment).is_at_most(500) }

  it do
    is_expected.to validate_numericality_of(:rating).is_greater_than(0)
    is_expected.to validate_numericality_of(:rating).is_less_than_or_equal_to(5)
  end
end
