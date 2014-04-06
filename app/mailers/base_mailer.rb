class BaseMailer < ActionMailer::Base
  default from: Figaro.env.site_email
end
