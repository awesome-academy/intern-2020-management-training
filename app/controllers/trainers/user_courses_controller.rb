class Trainers::UserCoursesController < TrainersController
  before_action :logged_in_user, :trainer?
  before_action :get_course_user, only: :show

  def show
    @subjects = Subject.by_course params[:course_id]
  end

  private

  def get_course_user
    @course = Course.find_by id: params[:course_id]
    @user = User.find_by id: params[:id]
    return if @course && @user

    flash[:danger] = t "notice.error"
    redirect_to trainers_courses_path
  end
end
