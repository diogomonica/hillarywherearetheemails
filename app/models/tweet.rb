 class Tweet < ActiveRecord::Base
   def send_tweets!
        last_tweet = Tweet.last
        users = User.all
        puts "sending tweets to #{users.count} users for #{last_tweet.last_id}"
        users.each do |user|
            user.tweet("@realDonaldTrump Delete your account.", last_tweet)
        end
   end
 end
