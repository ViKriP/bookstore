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
      call.order_items.order(&:created_at)
    end

    private

    def unfinished_order
      @current_user.orders.where(state: 'in_progress').last if @current_user
    end

    def current_order(order_id)
      if @current_user
        order = Order.find_by(id: order_id)

        unless order
          order = Order.new(user_id: @current_user.id)
          order.save(validate: false)
        end
      else
        order = Order.find_or_create_by(id: order_id)
        guest_order = GuestOrder.find_by(guest_id: @session_id)

        unless guest_order
          guest_order = GuestOrder.new(order_id: order.id, guest_id: @session_id)
          guest_order.save
        end
      end

      order
    end
  end
end
