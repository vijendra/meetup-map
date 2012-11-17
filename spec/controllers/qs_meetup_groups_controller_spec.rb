require 'spec_helper'

describe QsMeetupGroupsController do
  let(:qs_group) {FactoryGirl.create(:qs_meetup_group) }
  
  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
    
    it "assigns all meetup groups to @quantifiers" do
      get :index
      expect(assigns(:quantifiers)).to eq(QsMeetupGroup.order(:place).all)
    end
    
    it "assigns all meetup groups gmaps4rails to @markers" do
      get :index
      expect(assigns(:markers)).to eq(QsMeetupGroup.order(:place).all.to_gmaps4rails )
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', id: qs_group.id
      response.should be_success
    end
    
    it "assigns @quantifier" do
      get 'show', id: qs_group.id
      expect(assigns(:quantifier)).to eq(QsMeetupGroup.find(qs_group.id) )
    end
  end

end
