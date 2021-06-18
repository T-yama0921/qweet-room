require 'rails_helper'

RSpec.describe Tweet, type: :model do
  before do
    @tweet = FactoryBot.build(:tweet)
  end
  
  describe '新規クイズ投稿' do
    context '新規投稿できるとき' do
      it '全項目存在すれば投稿できる' do
        expect(@tweet).to be_valid
      end
      it 'answer_feedbackが空でも投稿できる' do
        @tweet.answer_feedback = ''
        expect(@tweet).to be_valid
      end
      it 'first_feedbackが空でも投稿できる' do
        @tweet.first_feedback = ''
        expect(@tweet).to be_valid
      end
      it 'second_feedbackが空でも投稿できる' do
        @tweet.second_feedback = ''
        expect(@tweet).to be_valid
      end
    end
    context '新規投稿できないとき' do
      it 'questionが空では投稿できない' do
        @tweet.question = ''
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include("Question can't be blank")
      end
      it 'answerが空では投稿できない' do
        @tweet.answer = ''
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include("Answer can't be blank")
      end
      it 'first_incorrectionが空では投稿できない' do
        @tweet.first_incorrection = ''
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include("First incorrection can't be blank")
      end
      it 'second_incorrectionが空では投稿できない' do
        @tweet.second_incorrection = ''
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include("Second incorrection can't be blank")
      end
      it 'userが紐付いていなければ投稿できない' do
        @tweet.user = nil
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include("User must exist")
      end
    end
  end
end