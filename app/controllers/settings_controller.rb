class SettingsController < ApplicationController
  before_action :authenticate_user!

  def address
    service = SettingsAddressService.new(current_user, params).call

    handle_result(service)
  end

  def user
    return delete_user if params[:delete_confirmation]

    update_user
  end

  private

  def update_user
    service = SettingsUserService.new(current_user, params).call

    bypass_sign_in(current_user) if params[:commit] == I18n.t('password_params')

    handle_result(service)
  end

  def delete_user
    current_user.destroy

    redirect_to root_path, notice: I18n.t('destroy_success')
  end

  def handle_result(service)
    if service
      redirect_to settings_path, notice: I18n.t('update_success')
    else
      flash[:alert] = I18n.t('fail')
      render :show
    end
  end
end
