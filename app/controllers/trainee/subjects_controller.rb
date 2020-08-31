class Trainee::SubjectsController < TraineesController
  before_action :logged_in_user, only: :show
  before_action :trainee?, only: %i(show)

  helper_method :get_ucs_progress

  def show
    @course = Course.find_by id: params[:course_id]
    @subject = Subject.find_by id: params[:id]
    render :show
  end
end
