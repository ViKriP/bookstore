class OrderItemsController < ApplicationController
  load_and_authorize_resource

  def create
    @order_item = OrderItemService.new(current_user_order, order_item_params).call

    if @order_item.save
      redirect_to request.referer, notice: I18n.t('item_added')
    else
      redirect_to request.referer, alert: I18n.t('error')
    end
  end

  def update
    if @order_item.update(order_item_params)
      redirect_to cart_path, notice: I18n.t('item_updated')
    else
      redirect_to cart_path, alert: I18n.t('error')
    end
  end

  def destroy
    if @order_item.destroy
      redirect_to cart_path, notice: I18n.t('item_removed')
    else
      redirect_to cart_path, alert: I18n.t('error')
    end
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :book_id)
  end
end
