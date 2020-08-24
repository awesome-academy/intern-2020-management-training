class User < ApplicationRecord
  USER_PARAMS_PERMIT = %i(name email password).freeze
  VALID_EMAIL_REGEX = Settings.REGEX.model.user.email

  validates :name, presence: true,
            length: {maximum: Settings.validates.model.user.name.max_length}
  validates :email, presence: true,
            length: {maximum: Settings.validates.model.user.email.max_length},
            uniqueness: {case_sensitive: false},
            format: {with: VALID_EMAIL_REGEX}
  validates :password, presence: true,
            length: {minimum: Settings.validates.model.user.pwd.min_length},
            allow_nil: true

  enum role: {trainee: Settings.roles.trainee, trainer: Settings.roles.trainer},
       _prefix: true

  has_secure_password
end
