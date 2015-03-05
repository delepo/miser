class WelcomeController < ApplicationController
  def index
    if params[:set_locale]
      redirect_to welcome_url(locale:params[:set_locale])
    end
  end
end
