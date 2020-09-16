FactoryBot.define do
  factory :position do
    name {Faker::Job.unique.position}
  end
end
