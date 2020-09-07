class Report < ApplicationRecord
  belongs_to :user
  belongs_to :course

  delegate :name, to: :course, prefix: true

  scope :order_by_date_report, ->{order date_of_report: :desc}
  scope :in_dates, ->(dates){where date_of_report: dates if dates.present?}
  scope :uniq_date, ->{select(:date_of_report).distinct}
  scope :with_user_id, ->(user_id){where user_id: user_id if user_id.present?}
end
