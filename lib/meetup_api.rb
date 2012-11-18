# encoding: utf-8
class MeetupApi
  require 'rmeetup'
  
  #TODO: make the key configurable
  def initialize()
    RMeetup::Client.api_key = "7d6585e3e2a111983b3177711467"
  end
   
  def fetch(type, options)
    RMeetup::Client.fetch(type.to_sym, options)  
  end
 
end
