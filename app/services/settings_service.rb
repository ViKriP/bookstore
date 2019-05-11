class SettingsService
  attr_accessor :update_required

  def initialize(user, params)
    @user = user
    @params = params
  end

  def call
    case @params[:commit]
    when 'email' then user_email
    when 'info' then user_info
    when 'password' then user_password
    when 'billing_address' then user_billing_address
    when 'shipping_address' then user_shipping_address
    end
  end

  def form_valid?
    return @user_address[:billing].valid? if @params[:commit] == 'billing_address'
    return @user_address[:shipping].valid? if @params[:commit] == 'shipping_address'

    @user.valid?
  end

  private

  def user_email
    @user.skip_reconfirmation!
    @user.update(user_params)
  end

  def user_info
    @user.update(user_params)
  end

  def user_password
    @user.update_with_password(user_params)
  end

  def user_billing_address
    if @user.billing_address
      @user.billing_address.update(user_params[:billing_address_attributes])
    else
      @user.create_billing_address(user_params[:billing_address_attributes])
    end
  end

  def user_shipping_address
    if @user.shipping_address
      @user.shipping_address.update(user_params[:shipping_address_attributes])
    else
      @user.create_shipping_address(user_params[:shipping_address_attributes])
    end
  end

  def user_params
    @params.require(:user).permit(
      :email, :first_name, :last_name, :current_password, :password, :password_confirmation,
      billing_address_attributes: %i[first_name last_name address zip city country phone],
      shipping_address_attributes: %i[first_name last_name address zip city country phone]
    )
  end
end
