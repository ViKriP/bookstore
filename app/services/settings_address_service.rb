class SettingsAddressService
  attr_accessor :update_required

  def initialize(user, params)
    @user = user
    @params = params
  end

  def call
    case @params[:commit]
    when 'billing_address' then billing_address
    when 'shipping_address' then shipping_address
    end
  end

  private

  def billing_address
    if @user.billing_address
      @user.billing_address.update(user_params[:billing_address])
    else
      @user.create_billing_address(user_params[:billing_address])
    end
  end

  def shipping_address
    if @user.shipping_address
      @user.shipping_address.update(user_params[:shipping_address])
    else
      @user.create_shipping_address(user_params[:shipping_address])
    end
  end

  def user_params
    @params.require(:user).permit(
      billing_address: %i[first_name last_name address zip city country phone],
      shipping_address: %i[first_name last_name address zip city country phone]
    )
  end
end
