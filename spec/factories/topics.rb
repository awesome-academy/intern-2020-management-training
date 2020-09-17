FactoryBot.define do
  factory :topic do
    name {Faker::Educator.unique.campus}
  end
end
