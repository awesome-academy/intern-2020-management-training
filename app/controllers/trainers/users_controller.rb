class Trainers::UsersController < TrainersController
  before_action :logged_in_user, :trainer?
  before_action :get_user, only: :show

  def index
    @users = User.by_name(params[:query]).page(params[:page])
                 .per Settings.pagination.course.default
    respond_to :js, :html
  end

  def show; end

  private

  def get_user
    @user = User.find_by id: params[:id] if params[:id].present?
    return if @user

    flash[:danger] = t "notice.error"
    redirect_to trainers_users_path
  end
end
