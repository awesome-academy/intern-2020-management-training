class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by email: params[:session][:email].downcase
    if @user&.authenticate params[:session][:password]
      log_in @user
      if trainer?
        redirect_to trainers_url
      else
        redirect_to trainee_courses_path
      end
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
