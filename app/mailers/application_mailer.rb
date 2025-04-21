class ApplicationMailer < ActionMailer::Base
  include Rails.application.routes.url_helpers
  default from: "Jannik Koester <info@koesterjannik.com>"
  layout "mailer"
end
