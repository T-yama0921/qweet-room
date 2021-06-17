FactoryBot.define do
  factory :tweet do
    question            { Faker::String.random }
    answer              { Faker::String.random }
    first_incorrection  { Faker::String.random }
    second_incorrection { Faker::String.random }
    answer_feedback     { Faker::String.random }
    first_feedback      { Faker::String.random }
    second_feedback     { Faker::String.random }
    association :user
  end
end
