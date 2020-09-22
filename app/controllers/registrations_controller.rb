class RegistrationsController < Devise::RegistrationsController
  layout "trainers"

  def update
    if current_user.valid_password? params[:user][:password]
      resource.errors[:password] << t("registrations.edit.notice_new_password")
      render :edit
    else
      super
    end
  end
end
