class User < ActiveRecord::Base
  EMAIL_OPTION = 'email'.freeze
  PHONE_OPTION = 'phone'.freeze
  DONT_CONTACT_OPTION = 'dont_contact'.freeze
  CONTACT_OPTIONS = [EMAIL_OPTION, PHONE_OPTION, DONT_CONTACT_OPTION].freeze

  CONFIRM_YES = 'yes'.freeze
  CONFIRM_WRONG_EMAIL = 'wrong_email'.freeze
  CONFIRM_WRONG_PHONE = 'wrong_phone'.freeze

  CONTACT_TIME_OPTIONS = %w(asap morning afternoon evening).freeze

  has_many :answers
end
