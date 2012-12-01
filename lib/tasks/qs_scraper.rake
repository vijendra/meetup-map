namespace :data do
  desc "scrape and save meetup groups place and url from quantifiedself.com"
  task :scrape_meetup_groups => :environment do
    puts "Started saving meetup groups."
    QuantifiedSelfScraper.new.save_groups
    puts "All meetup groups are saved."
  end
  
  desc "update all groups with meetup api data"
  task :update_groups_with_api_data => :environment do
    puts "Started updating groups with meetup api data."
    QsMeetupGroup.all.each do |group|
      group.update_meetup_details
    end  
    puts "All meetup groups are updated."
  end
  
  desc "fetch all historical tweet ids starting from 2008 - jan"
  task :fetch_historic_tweets => :environment do
    puts "Started fetching old tweets from topsy."
    TopsyTweet.save_old_tweets
    puts "All old tweets are saved."
  end
  
  desc "fetch all latest tweets from twitter"
  task :fetch_tweets => :environment do
    puts "Started fetching tweets."
    TwitterTweet.fetch(search_term: '#quantifiedself')
    puts "All tweets are saved."
  end
  
  desc "fetch all latest tweets from twitter"
  task :fetch_tweets => :environment do
    puts "Started fetching tweets."
    TwitterTweet.fetch(search_term: 'quantified self')
    puts "All tweets are saved."
  end
  
  desc "fetch complete tweet details from twitter, for tweets fetched from topsy"
  task :update_topsy_tweets => :environment do
    puts "Started updating tweets."
    ProcessTweet.update_from_twitter
    puts "All tweets are saved."
  end
end
