# encoding: utf-8
class QsMeetupGroup < ActiveRecord::Base
  attr_accessible :city, :country, :description, :group_id, :latitude, :longitude, :members, :name, 
                  :orgianizer, :photo_path, :place, :string, :url, :visibility, :zip
  
  acts_as_gmappable
  
  def gmaps
    true
  end
  
  def gmaps4rails_address
    "#{self.latitude}, #{self.longitude}"
  end

  def update_meetup_details
    #if self.name.blank?
    group = MeetupApi.new.fetch('groups', {group_urlname: self.url}).first
    self.update_attributes(name: group.name.force_encoding("iso-8859-1").to_s , photo_path: group.photo_url, group_id: group.id, description: group.description.force_encoding("iso-8859-1").to_s, members: group.members, visibility: group.visibility, country: group.country, city: group.city.force_encoding("iso-8859-1").to_s, zip: group.zip, latitude: group.lat, longitude: group.lon, orgianizer: group.organizer_name.force_encoding("iso-8859-1").to_s) unless group.blank?
    #end  
  end  
    
end
