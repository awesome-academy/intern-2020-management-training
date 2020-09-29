class Ability
  include CanCan::Ability

  def initialize user
    return if user.blank?

    if user.role_trainer?
      can :manage, :all
    else
      can %i(read update), User, id: user.id
      can :read, Course, user_courses: {user_id: user.id}
      can :update, UserTask, user_course_subject: {
        user_id: user.id, course: {status: :opening}
      }
      can :show, Subject, courses: {user_courses: {user_id: user.id}}
    end
  end
end
