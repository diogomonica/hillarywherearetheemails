 class Tweet < ActiveRecord::Base
   def send_tweets!
        last_tweet = Tweet.last
        users = User.all
        puts "sending hillary tweets to #{users.count} users for #{last_tweet.last_id}"
        users.each do |user|
            user.delay.tweet("@HillaryClinton But where are the emails? (via https://hillarywherearetheemails.com) https://twitter.com/HillaryClinton/status/#{last_tweet.last_id}", last_tweet.last_id)
        end
   end
 end