class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def user_signed_in?
    session[:user_id].present?
  end
  helper_method :user_signed_in?


  def authenticate_user!
    redirect_to new_session_path unless user_signed_in?
  end


  def current_user
    # the technique below is called memoization which fetched the user in this
   # case the first time you call the method and every subsequent time it uses
   # the one stored in the `@current_user` variable
    @current_user ||= User.find session[:user_id]
  end
  helper_method :current_user
end
