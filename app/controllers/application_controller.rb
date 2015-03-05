class ApplicationController < ActionController::Base
  # before_action :authorize, :set_locale_from_params
  before_action :authorize
  before_action :set_locale
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  protected
  
  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to login_url, notice: t('.notice')
    end
  end
  
  def set_locale
    if params[:locale]
      if I18n.available_locales.map(&:to_s).include?(params[:locale])
        I18n.locale = params[:locale]
      else
        flash.now[:alert] = "#{t('.errors.locale_not_available')}#{t('general.colon')}#{params[:locale]}"
        logger.error flash.now[:notice]
      end
    end
  end
  
  def default_url_options
    { locale: I18n.locale }
  end
end
