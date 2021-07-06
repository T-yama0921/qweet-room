class Tweet < ApplicationRecord

  belongs_to :user
  has_many :comments

  def self.search(search)
    if search != ""
      Tweet.where('text LIKE(?)', "%#{search}%")
    else
      Tweet.all
    end
  end

  with_options presence: true do
    validates :question
    validates :answer
    validates :first_incorrection
    validates :second_incorrection
  end

end
