class Trainee::ReportsController < TraineesController
  def index
    x_lastest_date = Report.order_by_date_report.uniq_date
                           .with_user_id(current_user.id)
                           .first Settings.report.limit_record
    @tmp_reports = current_user.reports
                               .in_dates(x_lastest_date.pluck(:date_of_report))
                               .order_by_date_report
    @reports = @tmp_reports.group_by(&:date_of_report)
  end
end
