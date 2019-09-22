class CreateSurvey
  attr_accessor :survey

  def initialize(admin, params)
    @admin = admin
    @question = params[:question]
  end

  def save
    return unless admin.can_create_survey?

    @survey = admin.surveys.build(survey_params)
    return unless @survey.valid?

    @survey.save!
    broadcast_survey!
  end

  private

  attr_reader :admin, :question

  def survey_params
    { question: question, members_count: admin.members.count, status: :running }
  end

  def broadcast_survey!
    @survey.admin.members.map do |member|
      token = SurveyToken.create!(survey: survey).token
      SurveyMailer.notify_member(member, token).deliver_now
    end
  end
end
