class Trainers::TopicsController < TrainersController
  def index
    @subjects = Topic.by_id(params[:topic]).first.subjects
    respond_to :js
  end
end
