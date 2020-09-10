module UiCustomHelper
  BG_CLASS = {
    course: {
      postponed: "warning", finished: "primary", opening: "warning",
      deleted: "danger", start: "secondary"
    }.freeze,
    course_subject: {
      start: "secondary", pending: "primary", inprogress: "warning",
      finished: "success", default: "secondary"
    }.freeze,
    user_task: {done: "success", doing: "danger"}.freeze,
    ucs: {done: "success", inprogress: "warning", default: "secondary"}.freeze
  }.freeze

  ICONS = {
    course_subject: {
      start: "circle", pending: "bolt", inprogress: "bolt", finished: "check",
      default: "circle"
    }.freeze,
    user_task: {done: "check", doing: "times", default: ""}.freeze,
    ucs: {done: "check", inprogress: "bolt", default: "sync-alt"}.freeze
  }.freeze

  def get_bg_status object, status
    return BG_CLASS[object.to_sym][:default] if status.blank?

    BG_CLASS[object.to_sym][status.to_sym]
  end

  def get_icon_status object, status
    return ICONS[object.to_sym][:default] if status.blank?

    ICONS[object.to_sym][status.to_sym]
  end

  def select_url obj
    if action_name.eql?("new")
      trainers_subjects_path
    else
      trainers_subject_path(obj)
    end
  end

  def select_btn
    action_name.eql?("new") ? t(".btn_add") : t(".btn_update")
  end
end
