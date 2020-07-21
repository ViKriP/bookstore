class OrderItemDecorator < Draper::Decorator
  delegate_all

  def order_item_subtotal
    h.number_to_currency(subtotal, unit: '€', precision: 2)
  end

  def subtotal
    book.price * quantity
  end
end
