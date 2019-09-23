class UpdateSurveyAverage
  def initialize(token, answer)
    @token = token
    @answer = answer
  end

  def self.call(token, answer)
    new(token, answer).call
  end

  def call
    survey_token = SurveyToken.find_by(token: token)
    return if survey_token.blank?

    @survey = survey_token.survey
    survey.update!(answer_count: answer_count, average_rating: average_rating)

    BroadcastFinishedSurveyWorker.perform_async(survey.id) if finished_survey?
  end

  private

  attr_reader :token, :answer, :survey

  def answer_count
    @answer_count ||= survey.answer_count + 1
  end

  def average_rating
    @average_rating ||= (survey.average_rating + answer.to_i) / answer_count
  end

  def finished_survey?
    survey.members.count == survey.answer_count
  end
end
