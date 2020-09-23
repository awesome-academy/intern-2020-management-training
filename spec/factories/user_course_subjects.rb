FactoryBot.define do
  factory :user_course_subject do
    user_course {FactoryBot.create :user_course}
    course_subject
    user
    progress {Faker::Number.decimal l_digits: 2}
  end
end
