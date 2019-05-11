module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]

    def checkout_login
      @built_user = User.new
    end

    def create
      if email_taken_in_quick_signup?
        redirect_to(user_session_path, notice: t('email_taken'))
      else
        prepare_temp_info if params[:checkout_signup]
        super
        return unless params[:checkout_signup]

        add_user_to_order
        resource.send_reset_password_instructions if params[:checkout_signup]
      end
    end

    protected

    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
    end

    def after_sign_up_path_for(resource)
      params[:checkout_signup] ? checkout_path(:address) : super(resource)
    end

    private

    def prepare_temp_info
      params[:user][:password] = params[:user][:password_confirmation] = Devise.friendly_token[0, 8]
    end

    def email_taken_in_quick_signup?
      params[:checkout_signup] && (User.where(email: params[:user][:email]).first&.email == params[:user][:email])
    end
  end
end
