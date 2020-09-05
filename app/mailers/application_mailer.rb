# frozen_string_literal: true

# Base mailer class
class ApplicationMailer < ActionMailer::Base
  default from: 'from@walletest.com'
  layout 'mailer'
end
