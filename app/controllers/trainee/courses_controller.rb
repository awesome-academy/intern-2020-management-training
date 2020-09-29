class Trainee::CoursesController < TraineesController
  before_action :authenticate_user!, :store_location
  before_action :get_course, only: :show

  load_and_authorize_resource

  def index
    @courses = current_user.courses.join_user_course.order_by_status
                           .order_by_start_date
                           .page(params[:page])
                           .per Settings.pagination.course.default
  end

  def show
    @subjects = @course.subjects.order_priority.page(params[:page])
                       .per Settings.pagination.course.default
    @trainees = @course.trainees.page(params[:page])
                       .per Settings.pagination.trainee.default
  end

  private

  def get_course
    @course = Course.find params[:id]
  end
end
