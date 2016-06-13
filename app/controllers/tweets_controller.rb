class TweetsController < ApplicationController
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def twitter_params
    params.require(:tweet).permit(:message)
  end

end
