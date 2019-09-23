class BroadcastNewSurvey
  def initialize(survey)
    @survey = survey
  end

  def self.call(survey)
    new(survey).call
  end

  def call
    survey.members.each do |member|
      survey_token = SurveyToken.create!(survey: survey)
      SurveyMailer.notify_member(member, survey_token).deliver_later
    end
  end

  private

  attr_reader :survey
end
