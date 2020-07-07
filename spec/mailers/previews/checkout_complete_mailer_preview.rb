class CheckoutCompleteMailerPreview < ActionMailer::Preview
  def order_confirm_email
    user = User.first
    CheckoutCompleteMailer.order_confirm_email(user, user.orders.first)
  end
end
