module UsersHelper
  def trainer?
    current_user.role_trainer? if logged_in?
  end

  def trainee?
    current_user.role_trainee? if logged_in?
  end

  def gender user
    return t("trainers.users.show.label_female") if user.gender_male?

    t "trainers.users.show.label_male"
  end

  def role user
    return t("trainers.users.show.label_role_trainer") if user.role_trainer?

    t "trainers.users.show.label_role_trainee"
  end

  def display_error object, method, name
    return unless object&.errors.present? && object.errors.key?(method)

    error = "#{name} #{object.errors.messages[method][0]}"
    content_tag :div, error, class: Settings.default_user.error_class
  end
end
