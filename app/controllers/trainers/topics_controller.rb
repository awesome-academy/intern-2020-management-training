class Trainers::TopicsController < TrainersController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @subjects = Topic.by_id(params[:topic]).first.subjects
    respond_to :js
  end
end
