class SurveyMailer < ApplicationMailer
  default from: 'bcrivelaro-happy-nel@email.com'.freeze

  def notify_member(member, survey_token)
    @member = member
    @survey_token = survey_token
    subject = I18n.t('survey_mailer.notify_member.subject')

    mail(to: @member.email, subject: subject)
  end

  def finished_survey(member, survey)
    @member = member
    @survey = survey
    subject = I18n.t('survey_mailer.finished_survey.subject')

    mail(to: @member.email, subject: subject)
  end
end
