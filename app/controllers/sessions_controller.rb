class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by email: params[:session][:email].downcase
    if @user&.authenticate params[:session][:password]
      log_in @user
      redirect_to trainer? ? trainers_root_path : trainee_root_path
    else
      flash[:danger] = t "notice.error"
      redirect_to login_url
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_url
  end
end
