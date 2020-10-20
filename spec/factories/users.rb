FactoryBot.define do
  factory :user do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    password {"123456"}
    date_of_birth {Faker::Date.between(from: "1970-09-23", to: "2010-08-25")}
    staff_type {Faker::Job.employment_type}
    address {Faker::Address.street_address}
    program_language_id {FactoryBot.create(:program_language).id}
    position_id {FactoryBot.create(:position).id}
    department_id {FactoryBot.create(:department).id}
    school_id {FactoryBot.create(:school).id}
    office_id {FactoryBot.create(:office).id}
    gender {Faker::Number.between from: 0, to: 1}
    role {Faker::Number.between from: 0, to: 1}
  end
end
