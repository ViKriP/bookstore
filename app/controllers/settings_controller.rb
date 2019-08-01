class SettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
    AddressesPresenter.new(@user).addresses
  end

  def update
    SettingsService.new(@user, params).call
    if @user.valid?
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
  end
end
