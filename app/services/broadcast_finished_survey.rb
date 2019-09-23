class BroadcastFinishedSurvey
  def initialize(survey)
    @survey = survey
  end

  def self.call(survey)
    new(survey).call
  end

  def call
    survey.update!(status: :finished)

    survey.members.each do |member|
      SurveyMailer.finished_survey(member, survey).deliver_later
    end
  end

  private

  attr_reader :survey
end
