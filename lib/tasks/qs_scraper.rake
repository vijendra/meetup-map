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
end
