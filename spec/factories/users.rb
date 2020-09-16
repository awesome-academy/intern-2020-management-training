FactoryBot.define do
  factory :user do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    password {"123456"}
    date_of_birth {Faker::Date.between(from: "1970-09-23", to: "2010-08-25")}
    staff_type {Faker::Job.employment_type}
    address {Faker::Address.full_address}
    program_language {FactoryBot.create :program_language}
    position {FactoryBot.create :position}
    department {FactoryBot.create :department}
    school {FactoryBot.create :school}
    office {FactoryBot.create :office}
    gender {Faker::Number.between from: 0, to: 1}
    role {Faker::Number.between from: 0, to: 1}
  end
end
