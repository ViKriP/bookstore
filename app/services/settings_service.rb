class SettingsService
  attr_accessor :update_required

  def initialize(user, params, user_address)
    @user = user
    @params = params
    @user_address = user_address
    @update_required = false
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
    if @user.addresses.find_by(address_type: :billing)
      @user_address[:billing].update(user_params['address'])
    else
      #puts "billing - user_params['address'] ==== #{user_params['address']} --- "
      @user.addresses.billing.create(user_params['address'])
      @update_required = true
    end
  end

  def user_shipping_address
    if @user.addresses.find_by(address_type: :shipping)
      @user_address[:shipping].update(user_params['address'])
    else
      #puts "shipping - user_params['address'] ==== #{user_params['address']} --- "
      @user.addresses.shipping.create(user_params['address'])
      @update_required = true
    end
  end

  def user_params
    @params.require(:user).permit(
      :email, :first_name, :last_name, :current_password, :password, :password_confirmation,
      address: %i[first_name last_name address zip city country phone]
    )
  end
end