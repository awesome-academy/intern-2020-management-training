module UsersHelper
  def trainer?
    current_user.role_trainer? if logged_in?
  end
end
