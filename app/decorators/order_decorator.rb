class OrderDecorator < Draper::Decorator
  delegate_all

  def order_subtotal
    h.number_to_currency(subtotal, unit: '€', precision: 2)
  end

  def order_discount
    h.number_to_currency(discount, unit: '€', precision: 2)
  end

  def order_total
    puts "=== order_total - #{total} ==="
    h.number_to_currency(total, unit: '€', precision: 2)
  end

  def order_date
    created_at.strftime('%B %d, %Y')
  end

  def delivery_price
    return h.number_to_currency(0, unit: '€', precision: 2) unless delivery

    h.number_to_currency(delivery.price, unit: '€', precision: 2)
  end
end
