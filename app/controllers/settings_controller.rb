class SettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
    @user_billing_address = @user.addresses.find_by address_type: :billing
    @user_shipping_address = @user.addresses.find_by address_type: :shipping

    #@my_addresses = @user.addresses.where(address_type: :billing)
    #@user.addresses.where(address_type: :billing).first
    #@user.addresses.find_by address_type: 0
  end

  def update
    #@user_billing_address = @user.addresses.find_by address_type: :billing

    SettingsService.new(@user, params).call
    if @user.valid?
      bypass_sign_in(@user) if params[:commit] == 'password'
      redirect_to settings_path, notice: I18n.t('update_success')
    else
      flash[:alert] = I18n.t('fail')
      render :show
    end
  end

  private

  def set_user
    @user = current_user
  end
end
