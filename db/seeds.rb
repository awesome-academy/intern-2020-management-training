require "faker"

(1..22).each do |id|
  Subject.create!(
    name: Faker::Science.unique.element,
    duration: Faker::Number.between(from: 1, to: 15),
    note: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true),
    image: Faker::Avatar.image
  )
end

Subject.all.each do |subject|
  count = Faker::Number.between(from: 2, to: 7)
  (1..count).each do
    subject.tasks.create!(
      name: Faker::Lorem.unique.sentence(word_count: 3)
    )
  end
end

(1..10).each do |id|
  Topic.create!(
    name: Faker::Educator.unique.campus
  )
end

(1..50).each do |id|
  TopicSubject.create!(
    subject_id: Faker::Number.between(from: 1, to: 22),
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

(1..25).each do |id|
  Course.create!(
    name: Faker::Educator.unique.course_name,
    note: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true),
    start_date: Faker::Date.between(from: '2019-11-23', to: '2020-01-25'),
    end_date: Faker::Date.between(from: '2020-01-26', to: '2020-06-27'),
    status: Faker::Number.between(from: 0, to: 3),
    image: Faker::Avatar.image
  )
end

Course.all.each do |course|
  count = Faker::Number.between(from: 3, to: 6)
  i = 0
  (1..count).each do
    i = i+1
    subject_id = Faker::Number.between(from: 1, to: 22)
    course.course_subjects.where(subject_id: subject_id).first_or_create(
      start_date: Faker::Date.between(from: '2019-11-23', to: '2020-01-25'),
      status: Faker::Number.between(from: 0, to: 3),
      priority: i
    )
  end
end

(0..50).each do |id|
  email = "account-#{id + 1}@sun-asterisk.com"
  role = 0
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

User.all.each do |user|
  count = Faker::Number.between(from: 3, to: 6)
  (1..count).each do
    course_id = Faker::Number.between(from: 1, to: 25)
    user.user_courses.where(course_id: course_id).first_or_create(
      start_date: Faker::Date.between(from: '2019-11-23', to: '2020-01-25'),
      end_date: Faker::Date.between(from: '2020-01-26', to: '2020-06-27'),
      progress: Faker::Number.decimal(l_digits: 2)
    )
  end
  
  user.courses.each do |course|
    course.course_subjects.each do |cs|
      UserCourseSubject.where(user_id: user.id, course_subject_id: cs.id).first_or_create(
        deadline: Faker::Date.between(from: '2019-11-23', to: '2020-01-25'),
        status: Faker::Number.between(from: 0, to: 1),
        progress: Faker::Number.decimal(l_digits: 2)
      )
    end
    count = Faker::Number.between(from: 3, to: 6)
    (1..count).each do 
      course.reports.create!(
        user_id: user.id,
        date_of_report: Faker::Date.between(from: '2019-11-23', to: '2020-01-25'),
        work_done: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true),
        issue: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true),
        tomorrow_plan: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true),
      )
    end
  end
  user.user_course_subjects.each do |ucs|
    ids = ucs.course_subject.subject.tasks.ids
    ids.each do |id|
      ucs.user_tasks.where(task_id: id).first_or_create(
        status: Faker::Number.between(from: 0, to: 1)
      )
    end
  end
end
