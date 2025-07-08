class LanguagesController < ApplicationController
  def update
    locale = params[:locale]
    if I18n.available_locales.map(&:to_s).include?(locale)
      session[:locale] = locale
      current_user.update(language: locale) if user_signed_in?
    end
    redirect_back fallback_location: root_path
  end
end
