class Tweet < ApplicationRecord

  with_options presence: true do
    validates :question
    validates :answer
    validates :first_incorrection
    validates :second_incorrection
  end

end
