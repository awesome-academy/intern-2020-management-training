FactoryBot.define do
  factory :user_task do
    user_course_subject {FactoryBot.create :user_course_subject}
    task_id {Faker::Number.decimal l_digits: 1}
    status {Settings.progress.zero}
  end
end
