class CreditCardDecorator < Draper::Decorator
  delegate_all

  def secure_card_number
    "** ** ** #{last4.last(4)}"
  end

  def exp_date
    "#{exp_month} / #{exp_year}"
  end
end
