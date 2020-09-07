module TimeHelper
  def convert_datetime_to_date datetime
    Date.parse datetime.to_s
  end
end
