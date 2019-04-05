require 'rails_helper'

RSpec.describe Author, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  it { is_expected.to have_and_belong_to_many(:books) }

  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
end
