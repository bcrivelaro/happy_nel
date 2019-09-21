RSpec.describe SurveyHelper do
  describe '#status_badge' do
    context 'when running' do
      it 'returns expected span' do
        survey = create :survey, status: :running
        i18n = I18n.t("activerecord.attributes.survey.running")
        expected_span = "<span class=\"badge badge-warning\">#{i18n}</span>"

        span = status_badge(survey)

        expect(span).to eq(expected_span)
      end
    end

    context 'when finished' do
      it 'returns expected span' do
        survey = create :survey, status: :finished
        i18n = I18n.t("activerecord.attributes.survey.finished")
        expected_span = "<span class=\"badge badge-success\">#{i18n}</span>"

        span = status_badge(survey)

        expect(span).to eq(expected_span)
      end
    end
  end
end