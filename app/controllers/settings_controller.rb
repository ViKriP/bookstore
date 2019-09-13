class SettingsController < ApplicationController
  before_action :authenticate_user!

  def address
    SettingsAddressService.new(current_user, params).call

    result_valid
  end

  def user
    SettingsUserService.new(current_user, params).call

    return redirect_to root_path, notice: I18n.t('destroy_success') if params[:delete_confirmation]

    result_valid
  end

  private

  def result_valid
    if current_user.valid?
      bypass_sign_in(current_user) if params[:commit] == I18n.t('password_params')
      redirect_to settings_path, notice: I18n.t('update_success')
    else
      flash[:alert] = I18n.t('fail')
      render :show
    end
  end
end
