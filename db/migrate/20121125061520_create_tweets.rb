class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.datetime :tweeted_on
      t.string :from_user
      t.string :from_user_id
      t.string :in_reply_to_user_id_str
      #t.string :in_reply_to_status_id_str
      t.string :ancestry
      
      t.string :from_user_name
      t.string :tweet_id
      t.string :iso_language_code
      t.string :profile_image
      t.string :body

      t.timestamps
    end
    
    add_index(:tweets, :tweet_id)
    add_index(:tweets, :ancestry)
  end
end
