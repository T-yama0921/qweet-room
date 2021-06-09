class TweetsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_tweet, only: [:show, :edit, :update]
  before_action :redirect_to_index, only: [:edit, :update]


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

  def show
  end

  def edit
  end

  def update
    if @tweet.update(tweet_params)
      redirect_to tweet_path
    else
      render :edit
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

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def redirect_to_index
    redirect_to action: :index unless current_user.id == @tweet.user.id
  end

end