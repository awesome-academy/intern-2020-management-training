FactoryBot.define do
  factory :course do
    name {Faker::Name.unique.name}
    status {Settings.progress.zero}
    note {Faker::Lorem.words(number: 4)}
    start_date {Faker::Date.between(from: "2019-11-23", to: "2020-01-25")}
    image {Rack::Test::UploadedFile.new(Rails.root.join("spec/support/fixture/default.png"))}
  end
end
