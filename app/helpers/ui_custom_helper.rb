module UiCustomHelper
  BG_CLASS = {
    start: "secondary",
    pending: "primary",
    inprogress: "warning",
    finished: "success",
    done: "success",
    nilll: "danger",
    doing: "danger"
  }.freeze

  ICONS = {
    start: "circle",
    pending: "bolt",
    inprogress: "bolt",
    finished: "check",
    done: "check",
    doing: "times",
    nilll: "question"
  }.freeze

  def get_bg_status status
    return BG_CLASS[:nilll] if status.blank?

    BG_CLASS[status.to_sym]
  end

  def get_icon_status status
    return ICONS[:nilll] if status.blank?

    ICONS[status.to_sym]
  end

  def get_status object
    object.present? ? object.status : "nilll"
  end
end
