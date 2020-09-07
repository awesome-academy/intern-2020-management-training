class Trainee::CoursesController < TraineesController
  before_action :logged_in_user, :store_location, only: :index
  before_action :trainee?
  before_action :get_course, only: :show

  def index
    @courses = current_user.courses.order_by_status
                           .order_by_start_date
                           .page(params[:page])
                           .per Settings.pagination.course.default
  end

  def show
    @subjects = @course.subjects.page(params[:page])
                       .per Settings.pagination.course.default
  end

  private

  def get_course
    @course = Course.find_by id: params[:id] if params[:id]
    return if @course

    flash[:danger] = t "notice.error"
    redirect_back_or @course
  end
end
