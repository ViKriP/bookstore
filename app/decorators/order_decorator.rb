class OrderDecorator < Draper::Decorator
  delegate_all

  def order_subtotal
    h.number_to_currency(subtotal, unit: '€', precision: 2)
  end

  def order_discount
    h.number_to_currency(discount, unit: '€', precision: 2)
  end

  def order_total
    h.number_to_currency(total, unit: '€', precision: 2)
  end

  def order_date
    created_at.strftime('%B %d, %Y')
  end

  def delivery_price
    return h.number_to_currency(delivery&.price.to_f, unit: '€', precision: 2) unless delivery

    h.number_to_currency(delivery.price, unit: '€', precision: 2)
  end

  def subtotal
    order_items.joins(:book).sum('books.price * order_items.quantity')
  end

  def total
    total = subtotal - discount

    total += delivery&.price.to_f

    total > discount ? total : 1
  end

  def book_added?(book_id)
    OrderItem.exists?(order_id: self, book_id: book_id)
  end
end
