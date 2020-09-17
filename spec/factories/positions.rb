FactoryBot.define do
  factory :position do
    name {Faker::Job.position}
  end
end
