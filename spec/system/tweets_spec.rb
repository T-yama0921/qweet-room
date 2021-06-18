require 'rails_helper'

RSpec.describe 'ツイート投稿', type: :system do
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
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（question）
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

RSpec.describe 'ツイート編集', type: :system do
  before do
    @tweet1 = FactoryBot.create(:tweet)
    @tweet2 = FactoryBot.create(:tweet)
  end
  context 'ツイート編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿したツイートの編集ができる' do
      # ツイート1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'email', with: @tweet1.user.email
      fill_in 'password', with: @tweet1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # ツイート1に「編集」へのリンクがあることを確認する
      expect(
        all('.user')[1].find('.tweet-btn')
      ).to have_link '編集', href: edit_tweet_path(@tweet1)
      # 編集ページへ遷移する
      visit edit_tweet_path(@tweet1)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#tweet_question').value
      ).to eq(@tweet1.question)
      expect(
        find('#tweet_answer').value
      ).to eq(@tweet1.answer)
      expect(
        find('#tweet_first_incorrection').value
      ).to eq(@tweet1.first_incorrection)
      expect(
        find('#tweet_second_incorrection').value
      ).to eq(@tweet1.second_incorrection)
      expect(
        find('#tweet_answer_feedback').value
      ).to eq(@tweet1.answer_feedback)
      expect(
        find('#tweet_first_feedback').value
      ).to eq(@tweet1.first_feedback)
      expect(
        find('#tweet_second_feedback').value
      ).to eq(@tweet1.second_feedback)
      # 投稿内容を編集する
      fill_in 'tweet_question', with: "#{@tweet1.question}+編集済"
      fill_in 'tweet_answer', with: "#{@tweet1.answer}+編集済"
      fill_in 'tweet_first_incorrection', with: "#{@tweet1.first_incorrection}+編集済"
      fill_in 'tweet_second_incorrection', with: "#{@tweet1.second_incorrection}+編集済"
      fill_in 'tweet_answer_feedback', with: "#{@tweet1.answer_feedback}+編集済"
      fill_in 'tweet_first_feedback', with: "#{@tweet1.first_feedback}+編集済"
      fill_in 'tweet_second_feedback', with: "#{@tweet1.second_feedback}+編集済"
      # 編集してもTweetモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Tweet.count }.by(0)
      # 詳細ページに遷移したことを確認する
      expect(current_path).to eq(tweet_path(@tweet1))
      # トップページに遷移する
      visit root_path
      # トップページには先ほど変更した内容のツイートが存在することを確認する（question）
      expect(page).to have_content("#{@tweet1.question}+編集済")
    end
  end
  context 'ツイート編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したツイートの編集画面には遷移できない' do
      # ツイート1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'email', with: @tweet1.user.email
      fill_in 'password', with: @tweet1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # ツイート2に「編集」へのリンクがないことを確認する
      expect(all('.user')[0]).to have_no_link '編集', href: edit_tweet_path(@tweet1)
    end
    it 'ログインしていないとツイートの編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # ツイート1に「編集」へのリンクがないことを確認する
      expect(all('.user')[1]).to have_no_link '編集', href: edit_tweet_path(@tweet1)
      # ツイート2に「編集」へのリンクがないことを確認する
      expect(all('.user')[0]).to have_no_link '編集', href: edit_tweet_path(@tweet1)
    end
  end
end

RSpec.describe 'ツイート削除', type: :system do
  before do
    @tweet1 = FactoryBot.create(:tweet)
    @tweet2 = FactoryBot.create(:tweet)
  end
  context 'ツイート削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿したツイートの削除ができる' do
      # ツイート1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'email', with: @tweet1.user.email
      fill_in 'password', with: @tweet1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # ツイート1に「削除」へのリンクがあることを確認する
      expect(all('.user')[1]).to have_link '削除', href: tweet_path(@tweet1)
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect{
        all('.user')[1].find_link('削除', href: tweet_path(@tweet1)).click
      }.to change { Tweet.count }.by(-1)
      # トップページに遷移したことを確認する
      expect(current_path).to eq(root_path)
      # トップページにはツイート1の内容が存在しないことを確認する（テキスト）
      expect(page).to have_no_content("#{@tweet1.question}")
    end
  end
  context 'ツイート削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したツイートの削除ができない' do
      # ツイート1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'email', with: @tweet1.user.email
      fill_in 'password', with: @tweet1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # ツイート2に「削除」へのリンクがないことを確認する
      expect(all('.user')[0]).to have_no_link '削除', href: tweet_path(@tweet2)
    end
    it 'ログインしていないとツイートの削除ボタンがない' do
      # トップページに移動する
      visit root_path
      # ツイート1に「削除」へのリンクがないことを確認する
      expect(all('.user')[1]).to have_no_link '削除', href: tweet_path(@tweet1)
      # ツイート2に「削除」へのリンクがないことを確認する
      expect(all(".user")[0]).to have_no_link '削除', href: tweet_path(@tweet2)
    end
  end
end

RSpec.describe 'ツイート詳細', type: :system do
  before do
    @tweet = FactoryBot.create(:tweet)
  end
  it 'ログイン状態問わず、ユーザーはツイート詳細ページに遷移してクイズの選択肢とフィードバックが表示される' do
    # トップページのツイートに「詳細」へのリンクがある
    visit root_path
    expect(
      find('.new-post-questions').find('.question-box')
    ).to have_link @tweet.question, href: tweet_path(@tweet)
    # 詳細ページに遷移する
    visit tweet_path(@tweet)
    # 詳細ページにツイートの内容が含まれている
    expect(page).to have_content(@tweet.question)
    expect(page).to have_selector('#answer-choice')
    expect(page).to have_selector('#first-incorrection-choice')
    expect(page).to have_selector('#second-incorrection-choice')
    # フィードバックが表示されていないことを確認する
    expect(page).to have_no_content(@tweet.answer_feedback)
    expect(page).to have_no_content(@tweet.first_feedback)
    expect(page).to have_no_content(@tweet.second_feedback)
  end
  it '正解の選択肢を選択すると、正解のフィードバックが表示される' do
    # 詳細ページに遷移する
    visit tweet_path(@tweet)
    # 正解の選択肢をクリックする
    find_by_id('answer-choice').click
    # 正解のフィードバックが表示されていることを確認する
    expect(page).to have_content(@tweet.answer_feedback)
    # 不正解１と不正解２のフィードバックは表示されていないことを確認する
    expect(page).to have_no_content(@tweet.first_feedback)
    expect(page).to have_no_content(@tweet.second_feedback)
    # 残りの選択肢をクリックしてもフィードバックは追加で表示されないことを確認する
    find_by_id('first-incorrection-choice').click
    find_by_id('second-incorrection-choice').click
    expect(page).to have_no_content(@tweet.first_feedback)
    expect(page).to have_no_content(@tweet.second_feedback)
  end
  it '不正解１の選択肢を選択すると、不正解１のフィードバックが表示される' do
    # 詳細ページに遷移する
    visit tweet_path(@tweet)
    # 不正解１の選択肢をクリックする
    find_by_id('first-incorrection-choice').click
    # 不正解１のフィードバックが表示されていることを確認する
    expect(page).to have_content(@tweet.first_feedback)
    # 不正解２と正解のフィードバックは表示されていないことを確認する
    expect(page).to have_no_content(@tweet.answer_feedback)
    expect(page).to have_no_content(@tweet.second_feedback)
    # 残りの選択肢をクリックしてもフィードバックは追加で表示されないことを確認する
    find_by_id('answer-choice').click
    find_by_id('second-incorrection-choice').click
    expect(page).to have_no_content(@tweet.answer_feedback)
    expect(page).to have_no_content(@tweet.second_feedback)
  end
  it '不正解２の選択肢を選択すると、不正解２のフィードバックが表示される' do
    # 詳細ページに遷移する
    visit tweet_path(@tweet)
    # 不正解２の選択肢をクリックする
    find_by_id('second-incorrection-choice').click
    # 不正解２のフィードバックが表示されていることを確認する
    expect(page).to have_content(@tweet.second_feedback)
    # 正解と不正解１のフィードバックは表示されていないことを確認する
    expect(page).to have_no_content(@tweet.answer_feedback)
    expect(page).to have_no_content(@tweet.first_feedback)
    # 残りの選択肢をクリックしてもフィードバックは追加で表示されないことを確認する
    find_by_id('answer-choice').click
    find_by_id('first-incorrection-choice').click
    expect(page).to have_no_content(@tweet.answer_feedback)
    expect(page).to have_no_content(@tweet.first_feedback)
  end
end