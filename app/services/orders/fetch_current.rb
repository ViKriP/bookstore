module Orders
  class FetchCurrent
    def initialize(current_user, session_order_id, session_id)
      @current_user = current_user
      @session_order_id = session_order_id
      @session_id = session_id
    end

    def call
      unfinished_order || current_order(@session_order_id)
    end

    def order_items
      call.order_items.order(:created_at)
    end

    private

    def unfinished_order
      return unless @current_user

      @current_user.orders.where(state: I18n.t('order_state.in_progress')).last
    end

    def current_order(order_id)
      return user_order(order_id) if @current_user

      guest_user_order(order_id)
    end

    def user_order(order_id)
      order = Order.find_by(id: order_id)

      return order if order

      order = Order.new(user_id: @current_user.id)
      order.save(validate: false)
      order
    end

    def guest_user_order(order_id)
      order = Order.find_or_create_by(id: order_id)
      guest_order = GuestOrder.find_by(guest_id: @session_id)

      return order if guest_order

      guest_order = GuestOrder.new(order_id: order.id, guest_id: @session_id)
      guest_order.save
      order
    end
  end
end
