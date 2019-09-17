class SettingsController < ApplicationController
  before_action :authenticate_user!

  def address
    service = SettingsAddressService.new(current_user, params).call

    result_valid(service)
  end

  def user
    return redirect_to root_path, notice: I18n.t('destroy_success') if params[:delete_confirmation]

    service = SettingsUserService.new(current_user, params).call

    bypass_sign_in(current_user) if params[:commit] == I18n.t('password_params')

    result_valid(service)
  end

  private

  def result_valid(service)
    if service
      redirect_to settings_path, notice: I18n.t('update_success')
    else
      flash[:alert] = I18n.t('fail')
      render :show
    end
  end
end
