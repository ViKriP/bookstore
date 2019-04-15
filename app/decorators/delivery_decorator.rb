class DeliveryDecorator < Draper::Decorator
  delegate_all

  def term
    "#{min_term} to #{max_term} days"
  end

  def delivery_price
    h.number_to_currency(price, unit: '€', precision: 2)
  end
end