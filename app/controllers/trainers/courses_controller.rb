class Trainers::CoursesController < TrainersController
  before_action :logged_in_user
  before_action :trainer?, only: :index

  def index
    @courses = Course.by_start_date.order_by_status
                     .page(params[:page])
                     .per Settings.pagination.course.default
  end
end
