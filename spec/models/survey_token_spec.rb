RSpec.describe SurveyToken, type: :model do
  describe 'associations' do
    it { should belong_to(:survey) }
  end

  describe 'callbacks' do
    it 'generates a token when creating' do
      survey = create :survey
      survey_token = SurveyToken.new(survey: survey)

      survey_token.save

      expect(survey_token.token).to be_present
    end
  end
end
