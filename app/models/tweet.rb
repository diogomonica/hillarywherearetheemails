 class Tweet < ActiveRecord::Base
   def send_tweets!
        puts "this is a job that is supposed to send tweets to #{User.all.count} users"
   end
 end
