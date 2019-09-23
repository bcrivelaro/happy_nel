class BroadcastFinishedSurveyWorker
  include Sidekiq::Worker

  def perform(survey_id)
    survey = Survey.find(survey_id)

    BroadcastFinishedSurvey.call(survey)
  end
end
