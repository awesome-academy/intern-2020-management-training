class Trainee::UserTasksController < TraineesController
  before_action :store_location, :find_user_task_by_id, only: :update
  before_action :check_correct_user, only: :update

  def update
    @course_id = @user_task.user_course_subject.cs_course_id
    if @user_task.update user_task_params
      respond_to :js
    else
      respond_to do |format|
        format.json err: I18n.t("flash.task.update_error")
      end
    end
  end

  private

  def user_task_params
    params.require(:user_task).permit UserTask::PERMITTED_CREATE_ATTRS
  end

  def find_user_task_by_id
    @user_task = UserTask.find_by id: params[:id] if params[:id]
    return if @user_task

    flash.now[:danger] = I18n.t "flash.task.not_exist"
    redirect_back_or @user_task
  end

  def check_correct_user
    return if correct_user?

    respond_to do |format|
      format.json err: I18n.t("flash.task.invalid_user")
    end
  end

  def correct_user?
    user = @user_task.user_course_subject.user
    current_user.eql? user
  end
end
