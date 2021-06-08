class TweetsController < ApplicationController

  def index
    @tweets = Tweet.all.order(created_at: :desc)
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      redirect_to root_path
    else
      render :new
    end
  end
end

private

def tweet_params
  params.require(:tweet).permit(
    :question,
    :answer,
    :first_incorrection,
    :second_incorrection,
    :answer_feedback,
    :first_feedback,
    :second_feedback,
  ).merge(
    user_id: current_user.id
  )
end