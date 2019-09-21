class SurveysController < ApplicationController
  before_action :authenticate_admin!
  before_action :check_members_count, only: %i[new create]

  def index
    @surveys = current_admin.surveys.paginate(page: params[:page])
  end

  def new
    @survey = current_admin.surveys.build
  end

  def create
    form = CreateSurvey.new(current_admin, survey_params)

    if form.save
      flash[:success] = t('.success')
      redirect_to surveys_path
    else
      @survey = form.survey
      render :new
    end
  end

  private

  def survey_params
    params.require(:survey).permit(:question)
  end

  def check_members_count
    return if current_admin.can_create_survey?

    redirect_to members_path
    flash[:error] = t('.you_need_members_to_create_surveys')
  end
end
