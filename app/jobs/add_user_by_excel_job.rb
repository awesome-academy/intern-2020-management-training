class AddUserByExcelJob < ApplicationJob
  queue_as :default

  def perform path_dir
    user_file = Roo::Spreadsheet.open path_dir
    result = process_file_user user_file
    User.import result[:user_models] if result[:user_models].present?
    process_log_file path_dir, result[:user_log] if result[:user_log].present?
  end

  private

  def process_file_user file
    row_hash = {name: "name", email: "email", date_of_birth: "date_of_birth",
                address: "address", gender: "gender"}
    user_models = []
    user_log = []
    file.sheet(0).parse(row_hash).each_with_index do |row, index|
      user_model = user_model(row)
      if user_model.valid?
        user_models << user_model
      else
        user_log << "row: #{index + 1} - error: " \
                    + user_model.errors.full_messages.join("|").to_s
      end
    end
    {user_models: user_models, user_log: user_log}
  end

  def user_model user
    date_of_birth = user[:date_of_birth] || Settings.default_user.birthday
    user_param = {name: user[:name], email: user[:email],
                  date_of_birth: date_of_birth,
                  password: Settings.default_user.password,
                  address: user[:address], gender: 0, program_language_id: 1,
                  school_id: 1, position_id: 1, department_id: 1,
                  office_id: 1}
    User.new user_param
  end

  def process_log_file path, content
    log_file = "#{path}.log"
    File.open log_file, "a+" do |file|
      file.write content.join "\n"
    end
  end
end
