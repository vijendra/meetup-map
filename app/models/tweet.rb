class Tweet < ActiveRecord::Base
  attr_accessible :body, :from_user, :from_user_id, :from_user_name, :iso_language_code, 
                  :profile_image, :tweet_id, :tweeted_on, :in_reply_to_user_id_str, 
                  :ancestry
 
  
  scope :tweets_with_replies, where("tweet_id IN (SELECT ancestry FROM tweets)")
  
  def children
    Tweet.scoped :conditions => "ancestry= '#{self.tweet_id}'"
  end 
end
