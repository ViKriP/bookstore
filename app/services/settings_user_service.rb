class SettingsUserService
  attr_accessor :update_required

  def initialize(user, params)
    @user = user
    @params = params
  end

  def call
    return user_destroy if @params[:delete_confirmation]

    case @params[:commit]
    when 'email' then user_email
    when 'info' then user_info
    when 'password' then user_password
    end
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

  def user_destroy
    @user.destroy
  end

  def user_params
    @params.require(:user).permit(
      :email, :first_name, :last_name, :current_password,
      :password, :password_confirmation
    )
  end
end
