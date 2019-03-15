module Users
    class RegistrationsController < Devise::RegistrationsController
      before_action :configure_sign_up_params, only: [:create]
  
      def checkout_login
        @built_user = User.new
      end
  
      def create
        prepare_temp_info if params[:checkout_signup]
        super
        return unless params[:checkout_signup]
  
        add_user_to_order
        resource.send_reset_password_instructions
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
        params[:user][:first_name] = params[:user][:last_name] = 'Customer'
        params[:user][:password] = params[:user][:password_confirmation] = Devise.friendly_token[0, 8]
      end
    end
  end