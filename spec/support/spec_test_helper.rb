module SpecTestHelper
  def login user
    request.session[:user_id] = user.id
  end

  def current_user
    User.find_by id: request.session[:user_id]
  end

  def trainer?
    current_user.role_trainer?
  end
end
