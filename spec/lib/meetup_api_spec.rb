require 'spec_helper'

describe MeetupApi do
  describe '#initialize' do
    it "should set the api client key" do
      MeetupApi.new
      RMeetup::Client.api_key.should == "7d6585e3e2a111983b3177711467"
    end
  end
  
  describe '#fetch' do
    it "should fetch the results from the rmeetup api" do
      RMeetup::Client.stub!(:fetch).with(:groups, {group_urlname: 'test'}).and_return(RMeetup::Collection.new)
      RMeetup::Client.should_receive(:fetch).with(:groups, {group_urlname: 'test'}) 
      MeetupApi.new.fetch('groups', {group_urlname: 'test'})
    end
  end
end
