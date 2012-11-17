class CreateQsMeetupGroups < ActiveRecord::Migration
  def change
    create_table :qs_meetup_groups do |t|
      t.string :place
      t.string :url
      t.string :name
      t.integer :group_id
      t.string :photo_path
      t.text :description
      t.integer :members
      t.string :visibility
      t.string :country
      t.string :city
      t.string :zip
      t.string :latitude
      t.string :longitude
      t.string :orgianizer
      
      t.timestamps
    end
  end
end
