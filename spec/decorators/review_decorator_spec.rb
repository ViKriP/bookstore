require 'rails_helper'

RSpec.describe ReviewDecorator do
  let(:review) { build_stubbed(:review).decorate }

  describe '#review_user_fullname' do
    let(:format) { "#{review.user.first_name} #{review.user.last_name}" }

    it "returns user's full name" do
      expect(review.review_user_fullname).to eq(format)
    end
  end

  describe '#review_user_initials' do
    let(:initials) { "#{review.user.first_name[0]}" }

    it "returns user's initials" do
      expect(review.review_user_initials).to eq(initials)
    end
  end

  describe '#review_time' do
    let(:format) { '%d/%m/%y' }

    it 'returns formatted time' do
      expect(review.review_time).to eq(review.created_at.strftime('%d/%m/%y'))
    end
  end
end
