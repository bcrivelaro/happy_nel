RSpec.describe SurveyToken, type: :model do
  describe 'associations' do
    it { should belong_to(:survey).counter_cache(true) }
  end

  describe 'callbacks' do
    it 'generates a token when creating' do
      survey = create :survey
      survey_token = SurveyToken.new(survey: survey)

      survey_token.save

      expect(survey_token.token).to be_present
    end
  end

  describe '#can_be_used?' do
    subject { survey_token.can_be_used? }

    context 'when used at is nil' do
      let(:survey_token) { build :survey_token, used_at: nil }

      it { is_expected.to be(true) }
    end

    context 'when used at is present' do
      let(:survey_token) { build :survey_token, used_at: 1.day.ago }

      it { is_expected.to be(false) }
    end
  end
end
