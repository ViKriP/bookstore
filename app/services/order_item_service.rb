class OrderItemService
  def initialize(order, params)
    @order = order
    @params = params
  end

  def call
    return unless @params

    return if @params.value?(nil)

    @order.order_items.new(@params) if @order
  end
end