module SubjectsHelper
  def bigger_with_now? date_time
    date_time > Time.zone.now
  end
end
