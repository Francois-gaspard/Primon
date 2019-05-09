class ApplicationMailer < ActionMailer::Base
  default from: User.email
  layout 'mailer'
end
