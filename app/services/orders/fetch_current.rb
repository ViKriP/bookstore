module Orders 
  class FetchCurrent
    def initialize(current_user, session_order_id)
      @current_user = current_user
      @session_order_id = session_order_id
    end

    def call
      unfinished_order || Order.find_or_create_by(id: @session_order_id)
    end

    def order_items
      call.order_items.sort_by(&:created_at)
    end

    private

    def unfinished_order
      @current_user.orders.where(state: 'in_progress').last if @current_user
    end
  end
end