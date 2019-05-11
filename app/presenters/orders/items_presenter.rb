module Orders
  class ItemsPresenter
    def sort_items(order)
      order.order_items.sort_by(&:created_at)
    end
  end
end
