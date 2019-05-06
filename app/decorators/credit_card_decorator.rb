class CreditCardDecorator < Draper::Decorator
  delegate_all

  def secure_card_number
    #"**** **** **** #{card_number.split('').last(4).join}"
    number.last(4)
  end
end