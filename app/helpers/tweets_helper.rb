module TweetsHelper
  def tweet_class(tweet)
    cls = "tweet clearfix"
    cls = cls +  ' reply_tweet' unless tweet.ancestry.blank?
    cls
  end
end
