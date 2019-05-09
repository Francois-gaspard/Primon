class UserMailer < ApplicationMailer
  require 'sendgrid-ruby'
  include SendGrid

  add_template_helper(ApplicationHelper)

  def initialize
    @client = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY']).client
  end

  def discount_email(scraping_result)
    product = scraping_result.product
    from = Email.new(email: User.email)
    subject = "New ATL for #{product.name}!"
    content = Content.new(
      type: 'text/html',
      value: ApplicationController.render(
        template: "user_mailer/discount_email",
        layout: nil,
        assigns: {product: product, monitored_url: scraping_result.monitored_url },
        )
    )
    to = Email.new(email: User.email, name: "Primon")

    mail = Mail.new(from, subject, to, content)
    @client.mail._('send').post(request_body: mail.to_json)
  end

  def scraping_error_email(monitored_url: monitored_url, message: message)
    from = Email.new(email: User.email)
    subject = "Scraping failed: #{monitored_url.product.name}#{monitored_url.domain_name}"
    content = Content.new(
      type: 'text/html',
      value: ApplicationController.render(
        template: "user_mailer/scraping_error_email",
        layout: nil,
        assigns: {monitored_url: monitored_url, message: message},
      )
    )
    to = Email.new(email: User.email)

    mail = Mail.new(from, subject, to, content)
    @client.mail._('send').post(request_body: mail.to_json)
  end

end
