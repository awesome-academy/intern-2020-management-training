class TrainersController < ApplicationController
  layout "trainers"

  check_authorization

  private

  def current_ability
    @current_ability ||= TrainerAbility.new current_user
  end
end
