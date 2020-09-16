FactoryBot.define do
  factory :task do
    name {Faker::Lorem.paragraph(sentence_count: 1)}
    subject
  end
end
