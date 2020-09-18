class EmailValidator < ActiveModel::EachValidator
  def validate_each record, attribute, value
    return if value =~ Settings.REGEX.model.user.email

    record.errors[attribute] << (options[:message] || I18n.t("notice.email"))
  end
end
