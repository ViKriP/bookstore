class DeliveryDecorator < Draper::Decorator
  delegate_all

  def delivery_price
    h.number_to_currency(price, unit: '€', precision: 2)
  end
end