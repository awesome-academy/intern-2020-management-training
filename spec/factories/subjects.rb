FactoryBot.define do
  factory :subject do
    name {Faker::Educator.subject}
    duration {Faker::Number.decimal(l_digits: 2, r_digits: 2)}
    note {Faker::Lorem.sentence(word_count: 5, supplemental: true,
      random_words_to_add: 3)}
    image {Rack::Test::UploadedFile.new(Rails.root.join("spec/support/fixture/default.png"))}

    before :create do |subject|
      subject.tasks = build_list :task, 2, subject: subject
    end
  end
end
