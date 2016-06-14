desc "This task is called by the Heroku scheduler add-on. It checks for new tweets and schedules responses if needed."
task :has_hillary_been_crazy_lately => :environment do
    puts "checking for recent hillary crazyness"
    last_tweet = Tweet.last

    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.omniauth_provider_key
      config.consumer_secret     = Rails.application.secrets.omniauth_provider_secret
    end

    options = {count: 200, include_rts: false, exclude_replies: true}
    if last_tweet != nil && last_tweet.last_id != nil
      options[:since_id] = last_tweet.last_id
    end

    tweets = client.user_timeline("HillaryClinton", options)

    # Pull new tweets. For a tweet to count it must:
    # * Be newer than the latest one we saw in the database
    # * Not be a reply, native retweet, start with RT/MT, or with "@ which is trump's retweet style
    to_reply = nil
    tweets.each do |tweet|
      if not tweet.text.start_with?('"@') and
        not tweet.text.start_with?('RT') and
        not tweet.text.start_with?('MT')
        to_reply = tweet
        break
      end
    end
    if to_reply != nil && last_tweet != nil
        last_tweet.update(last_id: to_reply.id)
        Tweet.last.send_tweets!
        puts "schedule task called send_tweets! for tweet id #{to_reply.id}"
    else
      # If there was no last tweet, we're bootstraping, use trump time
      if last_tweet == nil
        Tweet.create!(last_id: 742552474628837376)
      end
      puts "no latest tweet found"
    end
end