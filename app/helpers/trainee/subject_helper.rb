module Trainee::SubjectHelper
  def get_deadline current_user, course, subject_id
    id = course.course_subjects.find_by(subject_id: subject_id)&.id
    return unless id

    record = current_user.user_course_subjects.find_by course_subject_id: id
    record&.deadline if record.present?
  end

  def get_course_subject_status course, subject_id
    course.course_subjects.find_by(subject_id: subject_id)&.status
  end

  def get_user_subject_progress course, subject_id
    ucs_ids = course.course_subjects.where(subject_id: subject_id).select(:id)
    ucs_list = current_user.user_course_subjects
                           .where course_subject_id: ucs_ids
    done = ucs_list.status("done")
    if done.size == ucs_list.size
      I18n.t("status.user_cs.done")
    else
      I18n.t("status.user_cs.inprogress")
    end
  end

  def get_icon_task user, course, subject_id, task_id
    ucs_ids = course.course_subjects.where(subject_id: subject_id).select(:id)
    ucs_list = user.user_course_subjects.where course_subject_id: ucs_ids
    record = UserTask.find_by(task_id: task_id,
                              user_course_subject_id: ucs_list)&.status
    if record == I18n.t("status.user_task.done")
      I18n.t("icon.check_success")
    else
      I18n.t("icon.times")
    end
  end

  def get_bg_status status
    case status
    when I18n.t("status.course_subject.start")
      I18n.t("bg.secondary")
    when I18n.t("status.course_subject.pending")
      I18n.t("bg.primary")
    when I18n.t("status.course_subject.inprogress")
      I18n.t("bg.warning")
    when I18n.t("status.course_subject.finished")
      I18n.t("bg.success")
    end
  end

  def get_icon_status status
    case status
    when I18n.t("status.course_subject.start")
      I18n.t("icon.circle")
    when I18n.t("status.course_subject.pending")
      I18n.t("icon.bolt")
    when I18n.t("status.course_subject.inprogress")
      I18n.t("icon.bolt")
    when I18n.t("status.course_subject.finished")
      I18n.t("icon.check")
    end
  end
end
