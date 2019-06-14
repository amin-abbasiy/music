class ApplicationController < ActionController::Base
  include SessionHelper
  # rescue_from User::NotAuthorized, with: :permission
  protect_from_forgery with: :exception
  private
  def logged_in_user
    unless logged_in?
        flash[:danger] = "Please Login"
        redirect_to(login_path)
    end
 end
 def permission
  flash[:danger] = "Dont Permission!"
  redirect_to request.referrer
 end
#  def default_url_options
#   { locale: I18n.locale }
#  end
end
