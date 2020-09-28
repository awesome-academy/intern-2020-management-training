class Trainers::SearchTraineesController < TrainersController
  before_action :authenticate_user!
  authorize_resource User

  def index
    query = params[:query]
    return respond_error if query.blank?

    @users = User.by_name(query).role_trainee.exclude_ids params[:ids]
    @users = @users.page(params[:page]).per Settings.pagination.subject.default
    respond_to :js
  end

  private

  def respond_error
    respond_to do |format|
      format.json do
        message = {error: true, content: t("notice.error")}
        render json: message
      end
    end
  end
end
