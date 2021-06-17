require 'rails_helper'

RSpec.describe 'クイズ投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @tweet = FactoryBot.build(:tweet)
  end
  context 'ツイート投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 新規投稿ページへのボタンがあることを確認する
      expect(page).to have_content('クイズを投稿する')
      # 投稿ページに移動する
      visit new_tweet_path
      # フォームに情報を入力する
      fill_in 'tweet_question', with: @tweet.question
      fill_in 'tweet_answer', with: @tweet.answer
      fill_in 'tweet_answer_feedback', with: @tweet.answer_feedback
      fill_in 'tweet_first_incorrection', with: @tweet.first_incorrection
      fill_in 'tweet_first_feedback', with: @tweet.first_feedback
      fill_in 'tweet_second_incorrection', with: @tweet.second_incorrection
      fill_in 'tweet_second_feedback', with: @tweet.second_feedback
      # 送信するとTweetモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Tweet.count }.by(1)
      # トップページに遷移する
      expect(current_path).to eq(root_path)
      # トップページには先ほど投稿した内容のクイズが存在することを確認する（question）
      expect(page).to have_content(@tweet.question)
    end
  end
  context 'ツイート投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 投稿ページに移動しようとする
      visit new_tweet_path
      # ログインページへ戻されることを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end
