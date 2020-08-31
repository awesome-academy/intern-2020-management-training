class Trainers::SubjectsController < TrainersController
  before_action :logged_in_user, only: %i(index create new)

  def index
    @subjects = Subject.by_created_at.page(params[:page])
                       .per Settings.pagination.subject.default
  end

  def new
    @subject = Subject.new
    @subject.tasks.build
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash[:success] = t "flash.subject.success"
      redirect_to trainers_subjects_url
    else
      flash.now[:danger] = t "flash.subject.error"
      render :new
    end
  end

  private

  def subject_params
    params.require(:subject).permit Subject::PERMITTED_CREATE_ATTRS
  end
end
