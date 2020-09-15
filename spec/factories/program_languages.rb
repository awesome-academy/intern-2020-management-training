FactoryBot.define do
  factory :program_language do
    name {Faker::ProgrammingLanguage.unique.name}
  end
end
