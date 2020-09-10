class Trainers::SubjectsController < TrainersController
  before_action :logged_in_user, only: %i(index create new)
  before_action :load_subject, except: %i(index new create)
  before_action :in_active_course, only: :destroy

  def index
    @subjects = if params[:ids].present?
                  load_subject_for_search
                else
                  Subject.by_created_at.page(params[:page])
                         .per Settings.pagination.subject.default
                end
    respond_to :js, :html
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
      flash.now[:error] = t "flash.subject.error"
      render :new
    end
  end

  def show
    if @subject.blank?
      respond_to do |format|
        format.json do
          render json: {err: true}
        end
      end
    else
      respond_to :js, :html
    end
  end

  def edit
    respond_to :js
  end

  def update
    if @subject.update subject_params
      flash[:success] = t "flash.subject.success"
      redirect_to trainers_subjects_path
    else
      respond_to do |format|
        format.js{render :edit}
      end
    end
  end

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

    respond_to do |format|
      format.html
      format.json do
        render json: {err: @subject}
      end
      format.js
    end
  end

  def union_id_subjects topic_id
    id_subjects = []
    id_subjects = Topic.by_id(topic_id).first.subject_ids if topic_id.present?
    id_subjects.union params[:ids] if params[:ids].present?
  end

  def load_subject_for_search
    Subject.by_name(params[:query])
           .exclude_ids(union_id_subjects(params[:topic])).page(params[:page])
           .per Settings.pagination.subject.default
  end

  def in_active_course
    @course = @subject.active_course
    return if @course.blank?

    respond_to do |format|
      format.json do
        render json: {active_course: true}
      end
      format.js{redirect_to :index}
    end
  end
end
