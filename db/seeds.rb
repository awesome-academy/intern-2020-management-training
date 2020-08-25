require "faker"

(1..20).each do |id|
  Subject.create!(
    id: id,
    name: Faker::Educator.subject,
    duration: Faker::Number.between(from: 1, to: 15),
    note: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true),
    image: Faker::LoremFlickr.grayscale_image(size: "50x60", search_terms: ["education", "programming"]),
  )
end

(1..10).each do |id|
  Topic.create!(
    name: Faker::Educator.unique.campus
  )
end

(1..50).each do |id|
  TopicSubject.create!(
    subject_id: Faker::Number.between(from: 1, to: 20),
    topic_id: Faker::Number.between(from: 1, to: 10)
  )
end

(1..10).each do |id|
  ProgramLanguage.create!(
    name: Faker::ProgrammingLanguage.unique.name
  )
end

(1..10).each do |id|
  School.create!(
    name: Faker::University.unique.name
  )
end

(1..3).each do |id|
  Office.create!(
    name: Faker::Nation.unique.capital_city
  )
end

(1..3).each do |id|
  Position.create!(
    name: Faker::Job.unique.position
  )
end

(1..3).each do |id|
  Department.create!(
    name: Faker::Team.unique.name
  )
end

(1..15).each do |id|
  Course.create!(
    name: Faker::Educator.unique.course_name,
    note: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true),
    start_date: Faker::Date.between(from: '2019-11-23', to: '2020-01-25'),
    end_date: Faker::Date.between(from: '2020-01-26', to: '2020-06-27'),
    status: id%3==0 ? 0 : 1,
    image: Faker::Avatar.image
  )
end

(1..50).each do |id|
  email = "account-#{id + 1}@sun-asterisk.com"
  role = id<7 ? 1 : 0
  User.create!(
    name: Faker::Name.name,
    email: email,
    password: "123456",
    date_of_birth: Faker::Date.between(from: '1970-09-23', to: '2010-08-25'),
    staff_type: Faker::Job.employment_type,
    address: Faker::Address.full_address,
    program_language_id: Faker::Number.between(from: 1, to: 10),
    position_id: Faker::Number.between(from: 1, to: 3),
    department_id: Faker::Number.between(from: 1, to: 3),
    school_id: Faker::Number.between(from: 1, to: 10),
    office_id: Faker::Number.between(from: 1, to: 3),
    gender: Faker::Gender.type,
    role: role
  )
end

(1..80).each do |i|
  UserCourse.create!(
    course_id: Faker::Number.between(from: 1, to: 10),
    user_id: Faker::Number.between(from: 8, to: 50),
    start_date: Faker::Date.between(from: '2019-11-23', to: '2020-01-25'),
    end_date: Faker::Date.between(from: '2020-01-26', to: '2020-06-27'),
  )
end

(1..80).each do |i|
  Report.create!(
    course_id: Faker::Number.between(from: 1, to: 10),
    user_id: Faker::Number.between(from: 8, to: 50),
    date_of_report: Faker::Date.between(from: '2019-11-23', to: '2020-01-25'),
    work_done: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true),
    issue: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true),
    tomorrow_plan: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true),
  )
end

(1..50).each do |i|
  CourseSubject.create!(
    course_id: Faker::Number.between(from: 1, to: 10),
    subject_id: Faker::Number.between(from: 3, to: 13),
    start_date: Faker::Date.between(from: '2019-11-23', to: '2020-01-25'),
    status: i%7==1 ? 0 : 1
  )
end

(1..50).each do |i|
  UserCourseSubject.create!(
    user_id: Faker::Number.between(from: 1, to: 10),
    course_subject_id: Faker::Number.between(from: 1, to: 50),
    deadline: Faker::Date.between(from: '2019-11-23', to: '2020-01-25'),
    status: i%7==1 ? 0 : 1
  )
end

(1..50).each do |i|
  Task.create!(
    subject_id: Faker::Number.between(from: 3, to: 13),
    name: Faker::Lorem.unique.sentence(word_count: 3, supplemental: true)
  )
end

(1..50).each do |i|
  UserTask.create!(
    user_course_subject_id: Faker::Number.between(from: 3, to: 50),
    task_id: Faker::Number.between(from: 1, to: 50),
    status: i%7==1 ? 0 : 1
  )
end
