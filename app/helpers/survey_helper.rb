module SurveyHelper
  def status_badge(survey)
    status = I18n.t("activerecord.attributes.survey.#{survey.status}")
    badge_class = survey.running? ? 'warning' : 'success'

    content_tag('span', status, class: "badge badge-#{badge_class}")
  end
end