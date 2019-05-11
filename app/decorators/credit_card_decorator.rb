class CreditCardDecorator < Draper::Decorator
  delegate_all

  def secure_card_number
    "** ** ** #{number.last(4)}"
  end
end
