module Orders
  class FilteredStateQuery
    def initialize(orders, filter_state)
      @orders = orders
      @filter_state = filter_state
    end

    def call
      return unless @orders

      return @orders.where.not(state: 'in_progress') if !@filter_state || @filter_state == 'all'

      @orders.where(state: @filter_state)
    end
  end
end
