require 'rails_helper'

describe CheckoutCompleteMailer, type: :mailer do
  describe '#order_confirm_email' do
    let(:user) { create(:user) }
    let(:order) { create(:order) }
    let(:mail) { CheckoutCompleteMailer.order_confirm_email(user, order) }

    it 'renders the headers' do
      expect(mail.from).to eq(["viktor.biz17@gmail.com"])
      expect(mail.to).to eq([user.email])
      expect(mail.subject).to eq(I18n.t('complete.thank_you'))
    end
  end
end
