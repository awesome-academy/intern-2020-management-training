FactoryBot.define do
  factory :course_subject do
    course
    subject
    start_date {Faker::Date.between(from: "2019-11-23", to: "2020-01-25")}
    status {Faker::Number.between(from: 0, to: 3)}
    priority {Faker::Number.between(from: 0, to: 15)}
  end
end
