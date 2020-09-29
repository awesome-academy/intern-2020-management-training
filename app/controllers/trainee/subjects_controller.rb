class Trainee::SubjectsController < TraineesController
  before_action :authenticate_user!, :store_location, :load_course,
                :load_subject_by_course, :load_course_subject, only: :show

  def show
    @user_course_subject = @course_subject.user_course_subjects
                                          .find_by user_id: current_user.id
  end

  private

  def load_course
    @course = Course.find params[:course_id]
  end

  def load_subject_by_course
    @subject = @course.subjects.find params[:id]
  end

  def load_course_subject
    @course_subject = @course.course_subjects.find_by subject_id: @subject.id
    return if @course_subject

    flash[:error] = t "notice.error"
    redirect_to trainee_course_path(@course)
  end
end
