class Tweet < ApplicationRecord

  belongs_to :user
  has_many :comments

  with_options presence: true do
    validates :question
    validates :answer
    validates :first_incorrection
    validates :second_incorrection
  end

end
