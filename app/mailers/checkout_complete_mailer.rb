class CheckoutCompleteMailer < ApplicationMailer
  default from: 'bookstore@good-bookstore.herokuapp.com'

  def order_confirm_email(user, order)
    @user = user
    @order = order
    mail(to: @user.email, subject: t('complete.thank_you'))
  end
end
