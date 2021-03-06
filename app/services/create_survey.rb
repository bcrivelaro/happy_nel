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
    BroadcastNewSurvey.call(@survey)
  end

  private

  attr_reader :admin, :question

  def survey_params
    { question: question, status: :running, members: admin.members }
  end
end
