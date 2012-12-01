class TwitterTweet
  # This is used to collect latest tweets from twitter.  
   
  def self.fetch(params={})
    (1..15).each do |page|
       statuses = Twitter.search(params[:search_term], :rpp => 100, :page => page, :result_type => "mixed")
       statuses.each do |status|
         self.create(status)
       end
    end
  end
 
  def self.create(status)
    tweets = Tweet.where(tweet_id: status.attrs["id_str"]) #status.id_str throws error
    self.save(status) if tweets.blank?
  end
  
  def self.save(status)
    name = status.attrs["from_user_name"] #status.from_user_name throws error
    in_reply_to_status = status.attrs["in_reply_to_status_id_str"]
    in_reply_to_user = status.attrs["in_reply_to_user_id_str"]
    Tweet.create(tweet_id: status.id, body: status.text, from_user: status.from_user, 
                from_user_id: status.from_user_id, profile_image: status.profile_image_url, 
                from_user_name: name, iso_language_code: status.iso_language_code, 
                tweeted_on: status.created_at, in_reply_to_user_id_str: in_reply_to_user,
                ancestry: in_reply_to_status
                )
  end
end
