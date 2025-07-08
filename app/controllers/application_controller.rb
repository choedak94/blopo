class ApplicationController < ActionController::Base
        include Pagy::Backend
        before_action :set_locale
        before_action :configure_permitted_parameters, if: :devise_controller?

	protected

        def configure_permitted_parameters
                devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
                devise_parameter_sanitizer.permit(:account_update, keys: [:username, :language])
        end

        def set_locale
                I18n.locale = current_user&.language || I18n.default_locale
        end
end
