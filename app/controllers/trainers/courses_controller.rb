class Trainers::CoursesController < TrainersController
  before_action :logged_in_user, :trainer?
  before_action :get_course, except: %i(index create new)

  def index; end

  def create
    @course = Course.new course_params
    if @course.save
      flash.now[:success] = t "notice.success"
      redirect_to @course
    else
      flash.now[:danger] = t "notice.error"
      render :new
    end
  end

  def new
    @course = Course.new
    @course.course_subjects.build
    @course.user_courses.build
    @topics = Topic.all
    @subjects = @topics.first.subjects
  end

  def edit; end

  def show; end

  def update
    if @course.update course_params
      flash.now[:success] = t "notice.success"
      redirect_to @course
    else
      flash.now[:danger] = t "notice.error"
      render :edit
    end
  end

  def destroy; end

  private

  def course_params
    params.require(:course).permit Course::COURSE_PARAMS_PERMIT
  end

  def get_course
    @course = Course.find_by id: params[:id]
    return if @course

    flash[:danger] = t "notice.error"
    redirect_to trainers_courses_path
  end
end
