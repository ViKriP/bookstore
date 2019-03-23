class SettingsService
    def initialize(user, params)
      @user = user
      @params = params
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
      if @user.addresses.find_by address_type: :billing
        @user.addresses.find_by(address_type: :billing).update(user_params[:billing_address])
      else
        @user.addresses.find_by(address_type: :billing).create(user_params[:billing_address])
      end
    end
  
    def user_shipping_address
      if @user.addresses.find_by address_type: :shipping
        @user.addresses.find_by(address_type: :shipping).update(user_params[:shipping_address])
      else
        @user.addresses.find_by(address_type: :shipping).create(user_params[:shipping_address])
      end
    end
  
    def user_params
      @params.require(:user).permit(
        :email, :first_name, :last_name, :current_password, :password, :password_confirmation,
        billing_address: %i[first_name last_name address zip city country phone],
        shipping_address: %i[first_name last_name address zip city country phone]
      )
    end
  end