class Trainers::UsersController < TrainersController
  before_action :authenticate_user!
  before_action :get_user, except: %i(index new create)
  before_action :get_data
  load_and_authorize_resource

  def index
    @q = User.ransack params[:q]
    @users = @q.result.includes(:courses).page(params[:page])
               .per Settings.pagination.course.default
    respond_to :js, :html
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "notice.success"
      redirect_to trainers_user_path @user
    else
      flash.now[:danger] = t "notice.error"
      render :new
    end
  end

  def edit; end

  def show; end

  def update
    if @user.update user_params
      flash[:success] = t "notice.success"
      redirect_to trainers_user_path @user
    else
      flash.now[:danger] = t "notice.error"
      render :edit
    end
  end

  def destroy
    data = if @user.destroy
             {success: t("notice.success")}
           else
             {error: t("notice.error")}
           end
    render json: data
  end

  private

  def get_user
    @user = User.find_by id: params[:id] if params[:id].present?
    return if @user

    flash[:danger] = t "notice.error"
    redirect_to trainers_users_path
  end

  def user_params
    params.require(:user).permit User::USER_PARAMS_PERMIT
  end

  def get_data
    @data = {
      language: ProgramLanguage.all,
      position: Position.all,
      department: Department.all,
      school: School.all,
      office: Office.all,
      role: User.roles,
      gender: User.genders
    }
  end
end
