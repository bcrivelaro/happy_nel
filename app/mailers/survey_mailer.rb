class SurveyMailer < ApplicationMailer
  default from: 'bcrivelaro-happy-nel@email.com'.freeze
  include Rails.application.routes.url_helpers

  def notify_member(member, token)
    @member = member
    @token = token
    mail(to: @member.email, subject: I18n.t('.new_survey'))
  end
end
