class SettingsController < ApplicationController
  before_action :authenticate_user!

  def show
    AddressesPresenter.new(current_user).addresses
  end

  def update
    SettingsService.new(current_user, params).call
    if current_user.valid?
      bypass_sign_in(current_user) if params[:commit] == I18n.t('password_params')
      redirect_to settings_path, notice: I18n.t('update_success')
    else
      flash[:alert] = I18n.t('fail')
      render :show
    end
  end

  def destroy
    if params[:delete_confirmation]
      current_user.destroy
      redirect_to root_path, notice: I18n.t('destroy_success')
    else
      redirect_to settings_path
    end
  end
end
