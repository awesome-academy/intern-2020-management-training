FactoryBot.define do
  factory :user_course_subject do
    course_subject
    user
    progress {Faker::Number.decimal l_digits: 2}
  end
end
