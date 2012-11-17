require 'spec_helper'
require 'rmeetup'

describe QsMeetupGroup do
  let(:qs_group) {FactoryGirl.create(:qs_meetup_group) }
  
  [:city, :country, :description, :group_id, :latitude, :longitude, :members, :name, :orgianizer, :photo_path, 
                                  :place, :string, :url, :visibility, :zip].each do |attribute|
    it "should allow the mass assign for the field #{attribute}" do
       QsMeetupGroup.accessible_attributes.include?(attribute).should be_true
    end
  end  
  
  describe "#gmaps" do
    it "should return true" do
      qs_group.gmaps.should be_true
    end
  end
  
  describe "#gmaps4rails_address" do
    it "should return latitude and longitude" do
      qs_group.gmaps4rails_address.should == "#{qs_group.latitude}, #{qs_group.longitude}"
    end
  end
  
  describe "#gmaps4rails_infowindow" do
    it "should return name" do
       qs_group.gmaps4rails_infowindow.should == qs_group.name
    end
  end
  
  describe "#update_meetup_details" do
    before(:each) do
      @api = MeetupApi.new
      MeetupApi.stub!(:new).and_return(@api)
    end
    
    it "should call MeetupApi" do
      api_result = RMeetup::Collection.new
      MeetupApi.any_instance.should_receive(:fetch).with('groups', {group_urlname: qs_group.url}).and_return(api_result)
      api_result.should_receive(:first)
      qs_group.update_meetup_details
    end
     
    it "should update the record with data returned by meetup api" do
      group = RMeetup::Type::Group.new({"visibility"=>"public", "link"=>"http://www.meetup.com/quantifiedself-toronto/", "state"=>"ON", "organizer_id"=>"5529367", "join_mode"=>"0", "city"=>"Toronto", "who"=>"Members", "id"=>"1703116", "created"=>"Tue Sep 07 15:51:01 EDT 2010", "updated"=>"Fri Nov 16 14:08:42 EST 2012", "description"=>"The Toronto Quantified Self meetup is modeled on the Bay Area Quantified Self 'Show & Tell' meetings started in 2008 by Gary Wolf and Kevin Kelly in the Bay Area.", "name"=>"Quantified Self Toronto", "members"=>"307", "lat"=>"43.68000030517578", "group_photo_count"=>"0", "zip"=>"M4T 1B1", "lon"=>"-79.38999938964844", "join_info"=>"None", "photo_url"=>"http://photos1.meetupstatic.com/photos/event/2/8/b/global_20934651.jpeg", "group_urlname"=>"quantifiedself-toronto", "organizer_name"=>"Eric Boyd", "short_link"=>"", "country"=>"ca", "organizerProfileURL"=>"http://www.meetup.com/members/5529367/", "rating"=>"4.64", "daysleft"=>""})
      api_result = RMeetup::Collection.new
      api_result << group
      
      @api.stub!(:fetch).with('groups', {group_urlname: qs_group.url}).and_return(api_result) 
      qs_group.update_meetup_details
      
      qs_group.name.should == group.name
      qs_group.photo_path.should == group.photo_url
      qs_group.group_id.should == group.id 
      qs_group.description.should == group.description 
      qs_group.members.to_s.should == group.members
      qs_group.visibility.should == group.visibility 
      qs_group.country.should == group.country 
      qs_group.city.should == group.city 
      qs_group.zip.should == group.zip 
      qs_group.latitude.should == group.lat 
      qs_group.longitude.should == group.lon 
      qs_group.orgianizer.should == group.organizer_name
    end
    
    it "should not raise errors, if api doesn't return any thing" do
      api_result = RMeetup::Collection.new
      @api.stub!(:fetch).with('groups', {group_urlname: qs_group.url}).and_return(api_result) 
      lambda do
        qs_group.update_meetup_details
      end.should_not raise_exception
    end
  end
end
