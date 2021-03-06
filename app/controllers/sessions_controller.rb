class SessionsController < ApplicationController

  def new
    redirect_to '/auth/twitter'
  end

  def create
    auth = request.env["omniauth.auth"]
    user = User.where(:provider => auth['provider'],
                      :uid => auth['uid'].to_s).first || User.create_with_omniauth(auth)
    user.oauth_token = auth.credentials.token
    user.oauth_secret = auth.credentials.secret
    user.save
    reset_session
    session[:user_id] = user.id
    session[:access_token] = user.oauth_token
    session[:access_secret] = user.oauth_secret
    redirect_to hero_path
  end

  def destroy
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end
end
