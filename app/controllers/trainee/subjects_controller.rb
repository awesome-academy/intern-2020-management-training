class Trainee::SubjectsController < TraineesController
  before_action :logged_in_user, :trainee?, :store_location, only: :show

  def show
    @course = Course.find_by id: params[:course_id] if params[:course_id]
    @subject = Subject.find_by id: params[:id] if params[:id]
  end
end
