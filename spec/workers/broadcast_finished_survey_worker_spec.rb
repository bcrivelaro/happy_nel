RSpec.describe BroadcastFinishedSurveyWorker do
  let(:survey) { create :survey }

  describe '#perform' do
    it 'find object and call BroadcastFinishedSurvey.call' do
      expect(Survey).to receive(:find).with(survey.id).and_call_original
      expect(BroadcastFinishedSurvey).to receive(:call).with(survey)

      subject.perform(survey.id)
    end
  end

  context 'configuration' do
    let(:sidekiq_options) { subject.class.sidekiq_options }

    it { expect(sidekiq_options['queue']).to eql('default') }
  end
end
