class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  add_flash_types :danger, :info, :warning, :success
  
  after_action -> { flash.discard }, if: -> { request.xhr? }

  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    else
      return nil
    end
  end
end
