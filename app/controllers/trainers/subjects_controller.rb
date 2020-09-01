class Trainers::SubjectsController < TrainersController
  before_action :logged_in_user, only: %i(index create new)
  before_action :load_subject, only: :destroy

  def index
    @subjects = if params[:topic].present?
                  load_subject_for_search
                else
                  @subjects = Subject.by_created_at.page(params[:page])
                                     .per Settings.pagination.subject.default
                end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @subject = Subject.new
    @subject.tasks.build
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash[:success] = t "flash.subject.success"
      redirect_to trainers_subjects_path
    else
      flash.now[:danger] = t "flash.subject.error"
      render :new
    end
  end

  def show; end

  def destroy
    respond_to do |format|
      format.json do
        render json: {success: @subject.destroy, subject_id: @subject.id}
      end
      format.js{redirect_to :index}
    end
  end

  private

  def subject_params
    params.require(:subject).permit Subject::PERMITTED_CREATE_ATTRS
  end

  def load_subject
    @subject = Subject.find_by id: params[:id] if params[:id]
    return if @subject

    flash.now[:danger] = t "notice.error"
    redirect_to :index
  end

  def union_id_subjects topic_id
    id_subjects = Topic.by_id(topic_id).first.subject_ids
    id_subjects.union params[:ids] if params[:ids].present?
  end

  def load_subject_for_search
    Subject.by_name(params[:query])
           .exclude_ids union_id_subjects(params[:topic])
  end
end
