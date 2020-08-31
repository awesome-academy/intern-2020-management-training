class Trainee::CoursesController < TraineesController
  before_action :find_user, except: %i(index)
  before_action :logged_in_user
  before_action :trainee?

  helper_method :get_user_course_progress, :get_start_date_subject

  def index
    @courses = current_user.courses.by_start_date.page(params[:page])
                           .per Settings.pagination.course.default
  end

  def show
    @course = Course.find_by id: params[:id] if params[:id]
    @subjects = @course.subjects
    @trainees_number = @course.trainees.size
    @trainees = @course.trainees.page(params[:page])
                       .per Settings.pagination.trainee.default
    render :show
  end

  private

  def get_start_date_subject course, subject_id
    course.course_subjects.find_by(subject_id: subject_id).start_date
  end

  def get_user_course_progress course_id, user_id
    all_subject = get_subjects_in_user_course course_id, user_id
    return 0 if all_subject.blank?

    done = all_subject.status(:done)
    done.count * 100.0 / all_subject.count
  end

  def get_subjects_in_user_course course_id, user_id
    ids = get_subjects_ids course_id
    UserCourseSubject.by_course_subject(ids).by_user user_id
  end

  def get_subjects_ids course_id
    ids = []
    subject_ids = CourseSubject.where course_id: course_id
    subject_ids.each do |item|
      ids.push item.id
    end
    ids
  end
end
