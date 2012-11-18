# encoding: utf-8
class QsMeetupGroupsController < ApplicationController
  def index
    @quantifiers = QsMeetupGroup.order(:place).all
    @markers = @quantifiers.to_gmaps4rails do |group, marker|
      marker.title   group.name
      marker.infowindow render_to_string(:partial => "/qs_meetup_groups/detail", :locals => { :group => group})
      marker.json({ :id => group.id })
#      marker.title "name"
    end
  end

  def show
    @quantifier = QsMeetupGroup.find(params[:id])
  end
end
