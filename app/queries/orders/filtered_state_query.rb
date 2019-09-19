class Orders::FilteredStateQuery
  def initialize(orders, filter_state)
    @orders = orders
    @filter_state = filter_state
  end

  def call
    return unless @orders

    return @orders.where.not(state: 'in_progress') unless @filter_state

    @orders.where(state: @filter_state)
  end
end