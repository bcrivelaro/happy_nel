class AnswersController < ApplicationController
  before_action :set_survey_token, except: :thank_you

  def new; end

  def create
    if @survey_token && params[:answer].present?
      @survey_token.touch(:used_at)
      UpdateSurveyAverageWorker.perform_async(params[:token], params[:answer])
      redirect_to thank_you_path
    else
      redirect_to 'https://www.google.com'
    end
  end

  def thank_you; end

  private

  def set_survey_token
    @survey_token = SurveyToken.find_by(token: params[:token])
    redirect_to 'https://www.google.com' unless @survey_token&.can_be_used?
  end
end
