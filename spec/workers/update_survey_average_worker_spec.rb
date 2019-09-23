RSpec.describe UpdateSurveyAverageWorker do
  let(:token) { create(:survey_token).token }
  let(:answer) { '8' }

  describe '#perform' do
    it 'call UpdateSurveyAverage.call' do
      expect(UpdateSurveyAverage).to receive(:call).with(token, answer)

      subject.perform(token, answer)
    end
  end

  context 'configuration' do
    let(:sidekiq_options) { subject.class.sidekiq_options }

    it { expect(sidekiq_options['queue']).to eql('default') }
  end
end
