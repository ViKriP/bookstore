class SettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def update
    SettingsService.new(@user, params, @user_address).call

    if user_settings_valid?
      bypass_sign_in(@user) if params[:commit] == 'password'
      redirect_to settings_path, notice: I18n.t('update_success')
    else
      flash[:alert] = I18n.t('fail')
      render :show
    end
  end

  def destroy
    if params[:delete_confirmation]
      @user.destroy
      redirect_to root_path, notice: I18n.t('destroy_success')
    else
      redirect_to settings_path
    end
  end

  private

  def set_user
    @user = current_user
    @user_billing_address = @user.addresses.billing.first
    @user_shipping_address = @user.addresses.shipping.first

    @user_billing_address ||= create_address(:billing)
    @user_shipping_address ||= create_address(:shipping)

    @user_address = {billing: @user_billing_address, shipping: @user_shipping_address}
  end

  def user_settings_valid?
    @user.valid? && @user_address[:billing].valid? && @user_address[:shipping].valid?
  end

  def create_address(type_address)
    @new_address = @user.addresses.new(first_name: @user.first_name,
                                       last_name: @user.last_name,
                                       address_type: type_address)
    @new_address.save(validate: false)
    @new_address
  end
end
