class Trainers::SubjectCoursesController < TrainersController
  before_action :authenticate_user!
  before_action :get_course_user, only: :show
  authorize_resource User

  def show
    @users = User.by_course params[:course_id]
  end

  private

  def get_course_user
    @course = Course.find_by id: params[:course_id]
    @subject = Subject.find_by id: params[:id]
    @course_subject = CourseSubject.find_by(
      course_id: params[:course_id], subject_id: params[:id]
    )
    return if @course && @subject && @course_subject

    flash[:danger] = t "notice.error"
    redirect_to trainers_courses_path
  end
end
