module TableHelper
  def sizing subject
    (subject.current_page - 1) * subject.limit_value + 1
  end
end
