require 'spec_helper'

describe QuantifiedSelfScraper do
  let(:scraper) {QuantifiedSelfScraper.new }
 
  describe '#initialize' do
    it "should set the url" do
      scraper.url.should == "http://quantifiedself.com/"
    end
  end
  
  describe '#save_groups' do
    before(:each) do
      home_page_html = File.dirname(__FILE__) + '/../factories/QuantifiedSelf.html'
      FakeWeb.register_uri(:get, scraper.url, body: home_page_html, content_type: 'text/html')
      FakeWeb.register_uri(:get, 'http://bit.ly/gi2lvF', body: "<html></html>", content_type: 'text/html') #This url is inside html fixture
      @agent = Mechanize.new
      Mechanize.stub!(:new).and_return(@agent)
      @home_page = @agent.get(scraper.url) 
      @temp_page = @agent.get('http://bit.ly/gi2lvF')
      
      @agent.stub!(:get).with(scraper.url).and_return(@home_page) 
      @agent.stub!(:get).with('http://bit.ly/gi2lvF').and_return(@temp_page) 
      
    end
  
    it "should call save_self_quanitified_groups method to save all meetup groups" do
      scraper.should_receive(:save_self_quanitified_groups).with(@home_page, @agent)
      scraper.save_groups
    end
  
    it "should save total 8 quantified self meetup groups" do
      #We have 8 links in the html file fixture
      scraper.save_groups
      QsMeetupGroup.count.should == 8
    end
    
    it "should extract the group url" do
      scraper.save_groups
      group = QsMeetupGroup.find_by_place('Toronto')
      group.should_not be_nil 
      group.url.should == "quantifiedself-toronto"
    end
    
    it "should save the quantified self meetup group, which has pattern /bit.ly/ in its link" do
      @temp_page.stub!(:uri).and_return('http://www.meetup.com/Quantified-Self-Cape-Town') 
      scraper.save_groups
      group = QsMeetupGroup.find_by_place('Cape Town')
      group.should_not be_nil 
      group.url.should == "Quantified-Self-Cape-Town"
    end
  end
  
end
