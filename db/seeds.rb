ProgramLanguage.create! name: "php"

Position.create! name: "intern"

Department.create! name: "HN"

School.create! name: "NEU"

Office.create! name: "Handico"

User.create! name: "admin",
             email: "AdmiN@train.com",
             password: "123456",
             program_language_id: 1,
             position_id: 1,
             department_id: 1,
             school_id: 1,
             office_id: 1
