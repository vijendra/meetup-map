class QuantifiedSelfScraper
  attr_accessor :url
  
  def initialize()
    @url = "http://quantifiedself.com/"
  end
  
  def save_groups
    agent =  Mechanize.new
    home_page = agent.get(@url) 
    save_self_quanitified_groups(home_page, agent)
  end 
  
  private
   
  def save_self_quanitified_groups(page, agent)
    meetup_links = page.links_with(href: /www.meetup.com/)
    meetup_links.each do |ml|
      quantifier = QsMeetupGroup.where(place: ml.text).first
      QsMeetupGroup.create(place: ml.text, url:  ml.href.split('/').last) if quantifier.blank?
    end
    
    masked_meetup_links = page.links_with(href: /bit.ly/)
    masked_meetup_links.each do |ml|
      quantifier = QsMeetupGroup.where(place: ml.text).first
      if quantifier.blank?
        temp_page = agent.get(ml.href)
        #name = temp_page.search('h1#bannerGroupName span').text
        QsMeetupGroup.create(place: ml.text, url:  temp_page.uri.to_s.split('/').last)
      end  
    end

  end
  
end
