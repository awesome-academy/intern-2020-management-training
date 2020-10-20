class Trainee::UserTasksController < TraineesController
  before_action :authenticate_user!, :store_location,
                :find_user_task_by_id, only: :update

  authorize_resource User

  def update
    @course_id = @user_task.user_course_subject.cs_course_id
    if @user_task.update user_task_params
      respond_to :js
    else
      render json: {err: I18n.t("flash.task.update_error")}
    end
  end

  private

  def user_task_params
    params.require(:user_task).permit UserTask::PERMITTED_CREATE_ATTRS
  end

  def find_user_task_by_id
    @user_task = UserTask.find params[:id]
  end
end
