FactoryBot.define do
  factory :user_course do
    course {FactoryBot.create :course}
    user {FactoryBot.create :user}
    progress {Faker::Number.decimal l_digits: 2}
  end
end
