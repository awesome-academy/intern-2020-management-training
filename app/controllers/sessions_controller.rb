class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      log_in user
      flash[:success] = t "notice.success"
      redirect_to trainers_url if trainer?
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
