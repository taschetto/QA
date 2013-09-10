class User::ParameterSanitizer < Devise::ParameterSanitizer
    private
    def sign_up
    	default_params.permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
    def account_update
        default_params.permit(:first_name, :last_name, :about, :birthday, :email, :password, :password_confirmation, :current_password)
    end
end