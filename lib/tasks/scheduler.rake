desc "This task is called by the Heroku scheduler add-on"
task :update_feed => :environment do
    last_tweet = Tweet.last
    if last_tweet == nil
      Tweet.create!
    end
    Tweet.last.delay.send_tweets!
    puts "schedulle task called send_tweets!"
    return
end

