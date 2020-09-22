class SessionsController < Devise::SessionsController
  private

  def after_sign_in_path_for resource
    if resource.is_a?(User) && resource.role_trainer?
      trainers_courses_path
    else
      trainee_courses_path
    end
  end

  def after_sign_out_path_for _resource
    new_user_session_path
  end
end
