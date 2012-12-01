class TweetsController < ApplicationController
  def index
    @tweets = Tweet.order('tweeted_on desc').where('ancestry is null').where('tweeted_on is not null').page(params[:page]).per(50)
    #@tweets = Tweet.tweets_with_replies.page(params[:page]).per(50)
  end
end
