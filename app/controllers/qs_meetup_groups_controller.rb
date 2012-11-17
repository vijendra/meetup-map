class QsMeetupGroupsController < ApplicationController
  def index
    @quantifiers = QsMeetupGroup.order(:place).all
    @markers = @quantifiers.to_gmaps4rails   
  end

  def show
    @quantifier = QsMeetupGroup.find(params[:id])
  end
end
