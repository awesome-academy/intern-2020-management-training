class Trainee::UserCourseSubjectsController < TraineesController
  before_action :authenticate_user!, :load_user_course_subject,
                :all_task_done, only: :update

  def update
    ucs = @user_course_subject.update status: :done
    respond_to do |format|
      format.json do
        render json: {success: ucs}
      end
    end
  end

  private

  def load_user_course_subject
    @user_course_subject = current_user.user_course_subjects.find params[:id]
  end

  def all_task_done
    return if @user_course_subject.progress == Settings.done_percentage

    flash[:error] = t "notice.error"
    course_subject = @user_course_subject.course_subject
    course_id = course_subject.course_id
    subject_id = course_subject.subject_id
    redirect_to trainee_course_subject_path(course_id, subject_id)
  end
end
