module UiCustomHelper
  BG_CLASS = {
    start: "secondary",
    pending: "primary",
    inprogress: "warning",
    finished: "success",
    done: "success",
    nilll: "danger"
  }.freeze

  ICONS = {
    start: "circle",
    pending: "bolt",
    inprogress: "bolt",
    finished: "check",
    nilll: "times"
  }.freeze

  def get_bg_status status
    BG_CLASS[status.to_sym]
  end

  def get_icon_status status
    ICONS[status.to_sym]
  end

  def get_status object
    object.present? ? object.status : "nilll"
  end
end
