class TopsyTweet
  # This is used to collect hostoric tweet ids. Twitter doesn't provide access to old tweets. Topsy does.
  
  def self.save_old_tweets
    date = Time.parse('2012-11-01 12:00:00').to_date
    while date < Time.now.to_date.advance(:days => 1)
      end_date = date.advance(:days => 1)
      mintime = date.to_time.to_i
      maxtime = end_date.to_time.to_i
      puts "Fetching tweets from #{date} to #{end_date}"
      ['#quantifiedself'].each do |search_term|
        tweets = Topsy.search(search_term, mintime: mintime, maxtime: maxtime, type: 'tweet', perpage: 50)
        #Save page 1
        save_tweet(tweets.list)
        
        #Save rest of the pages
        (2 .. tweets.total.to_i/50).each do |page|
          tweets = Topsy.search(search_term, mintime: mintime, maxtime: maxtime, type: 'tweet', perpage: 50, page: page) 
          save_tweet(tweets.list) 
        end
      end
      
      date = end_date
    end
  end
  
  def self.save_tweet(list)
    list.each do |topsy|
      Tweet.find_or_create_by_tweet_id(topsy.url.split('/').last.strip) 
    end
  end
 
end
