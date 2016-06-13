class TweetsController < ApplicationController
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def check
    last_tweet = Tweet.last
    if last_tweet == nil
      Tweet.create!
    end
    Tweet.last.delay.send_tweets!
    return
  end

  def create
    # current_user.tweet(twitter_params[:message])
     current_user.tweet("testing my first twitter bot")
  end

  def twitter_params
    params.require(:tweet).permit(:message)
  end
end
