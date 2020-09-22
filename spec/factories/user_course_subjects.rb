FactoryBot.define do
  factory :user_course_subject do
    course_subject
    user
    user_course {FactoryBot.create :user_course}
    progress {Faker::Number.decimal l_digits: 2}
  end
end
