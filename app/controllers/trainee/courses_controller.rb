class Trainee::CoursesController < TraineesController
  before_action :logged_in_user
  before_action :trainee?, only: :index

  def index
    @courses = current_user.courses.order_by_status.order_by_start_date
                           .page(params[:page])
                           .per Settings.pagination.course.default
  end
end
