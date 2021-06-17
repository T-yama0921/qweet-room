FactoryBot.define do
  factory :tweet do
    question            { Faker::Lorem.question }
    answer              { Faker::Lorem.sentence }
    first_incorrection  { Faker::Lorem.sentence }
    second_incorrection { Faker::Lorem.sentence }
    answer_feedback     { Faker::Lorem.paragraph }
    first_feedback      { Faker::Lorem.paragraph }
    second_feedback     { Faker::Lorem.paragraph }
    association :user
  end
end
