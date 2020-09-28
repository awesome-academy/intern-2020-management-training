class Trainers::SubjectsController < TrainersController
  before_action :authenticate_user!
  before_action :load_subject, except: %i(index new create)
  before_action :in_active_course, only: :destroy
  protect_from_forgery only: %i(create new)
  load_and_authorize_resource

  def index
    @q = Subject.tasks_to(tasks_size_max).tasks_from(tasks_size_min)
                .ransack params[:q], auth_object: set_ransack_auth_object
    @status = Course.statuses
    @subjects = if params[:ids].present? || params[:query].present?
                  load_subject_for_search
                else
                  ransack_search
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
    respond_to :js, :html
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

  def tasks_size_min
    params.dig :q, :tasks_from
  end

  def tasks_size_max
    params.dig :q, :tasks_to
  end

  def set_ransack_auth_object
    trainer? ? :trainer : nil
  end

  def ransack_search
    @result = @q.result(distinct: true)
    @result.page(params[:page])
           .per Settings.pagination.subject.default
  end

  def subject_params
    params.require(:subject).permit Subject::PERMITTED_CREATE_ATTRS
  end

  def load_subject
    @subject = Subject.find_by id: params[:id] if params[:id]
    return if @subject

    respond_to do |format|
      format.html
      format.json do
        render json: {err: true}
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
