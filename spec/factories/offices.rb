FactoryBot.define do
  factory :office do
    name {Faker::Nation.unique.capital_city}
  end
end
