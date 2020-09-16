FactoryBot.define do
  factory :school do
    name {Faker::University.unique.name}
  end
end
