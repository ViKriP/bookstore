class SettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def update
    settings_service = SettingsService.new(@user, params, @user_address)

    settings_service.call

    set_user_addresses if settings_service.update_required

    #@user_address[:billing].valid? if @params[:commit] == 'billing_address'
    #@user_address[:shipping].valid? if @params[:commit] == 'shipping_address'
    #@user.valid?

    if settings_service.form_valid?
      bypass_sign_in(@user) if params[:commit] == I18n.t('password_params')
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

    set_user_addresses
  end

  def set_user_addresses
    user_billing_address = @user.addresses.billing.first
    user_shipping_address = @user.addresses.shipping.first

    user_billing_address ||= Address.new(first_name: @user.first_name,
                                         last_name: @user.last_name,
                                         address_type: :billing)
    user_shipping_address ||= Address.new(first_name: @user.first_name,
                                          last_name: @user.last_name,
                                          address_type: :shipping)

    @user_address = { billing: user_billing_address, shipping: user_shipping_address }
  end
end
