class SettingsService
    def initialize(user, params, user_address)
      @user = user
      @params = params
      @user_address = user_address
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
      if @user_address[:billing]
        @user_address[:billing].update(user_params['address'])
      else
        @user.addresses.create(user_params['address'])
      end
    end

    def user_shipping_address
      if @user_address[:shipping]
        @user_address[:shipping].update(user_params['address'])
      else
        @user.addresses.create(user_params['address'])
      end
    end

    def user_params
      @params.require(:user).permit(
        :email, :first_name, :last_name, :current_password, :password, :password_confirmation,
        address: %i[first_name last_name address zip city country phone]
      )
    end
  end