class CheckoutCompleteMailerPreview < ActionMailer::Preview
  def order_confirm_email
    CheckoutCompleteMailer.order_confirm_email(User.first, User.first.orders.first)
  end
end