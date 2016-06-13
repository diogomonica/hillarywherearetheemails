class User < ActiveRecord::Base
  def self.create_with_omniauth(auth)
    puts "self.create_with_omniauth: #{auth.inspect}"
    create! do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      if auth['info']
         user.name = auth['info']['name'] || ""
      end
      user.oauth_token = auth.credentials.token
      user.oauth_secret = auth.credentials.secret
    end
  end

  def tweet(tweet, reply_to)
    puts "about to tweet: #{tweet}"
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.omniauth_provider_key
      config.consumer_secret     = Rails.application.secrets.omniauth_provider_secret
      config.access_token        = oauth_token
      config.access_token_secret = oauth_secret
    end

    client.update(tweet, options: {in_reply_to_status_id: reply_to})
  end
end
