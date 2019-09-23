class UpdateSurveyAverageWorker
  include Sidekiq::Worker

  def perform(token, answer)
    UpdateSurveyAverage.call(token, answer)
  end
end
