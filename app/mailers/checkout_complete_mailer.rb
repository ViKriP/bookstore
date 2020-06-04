class CheckoutCompleteMailer < ApplicationMailer
  default from: 'viktor.biz17@gmail.com'

  def order_confirm_email(user, order)
    @user = user
    @order = order
    mail(to: @user.email, subject: t('complete.thank_you'))
  end
end
