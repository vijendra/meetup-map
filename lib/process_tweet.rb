class ProcessTweet

  #This method is used to update the tweets, fetched from topsy. They will contain the tweet_id only. Rest of the data has to be updated from twitter.
  def self.update_from_twitter
    Tweet.where(from_user: nil).order('tweet_id desc').each do |topsy_tweet|
      status = Twitter.status(topsy_tweet.tweet_id) rescue nil
      unless status.nil?
        user = status.user
        topsy_tweet.body                    = status.text
        topsy_tweet.tweeted_on              = status.created_at
        topsy_tweet.from_user               = user.screen_name
        topsy_tweet.from_user_id            = user.id
        topsy_tweet.profile_image           = user.profile_image_url
        topsy_tweet.from_user_name          = user.name
        topsy_tweet.iso_language_code       = user.lang
        topsy_tweet.ancestry                = status.in_reply_to_status_id
        topsy_tweet.in_reply_to_user_id_str = status.in_reply_to_user_id 
        topsy_tweet.save
      end           
    end  
  end
  
  #
  def fetch_root_tweets
    Tweet.where("body like '%#quantifiedself%'").where('ancestry is not null').each do |t|
      tweet = Tweet.find_by_tweet_id(t.ancestry)
      if tweet.blank?
        status = Twitter.status(t.ancestry) rescue nil
        TwitterTweet.save(status) if status
      end
    end
  end  
end
