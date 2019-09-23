RSpec.describe CreateSurvey do
  let(:admin) { create :admin }
  let(:valid_params) { { question: 'question' } }
  let(:invalid_params) { { question: '' } }

  describe '#save' do
    context 'when admin cannot create survey' do
      subject { CreateSurvey.new(admin, valid_params).save }

      it { is_expected.to be_falsey }
    end

    context 'when params are invalid' do
      before { create_list :member, 2, admin: admin }
      subject { CreateSurvey.new(admin, invalid_params).save }

      it { is_expected.to be_falsey }
    end

    context 'valid' do
      let(:service) { CreateSurvey.new(admin, valid_params) }
      subject { service.save }
      before do
        expect(BroadcastNewSurvey).to receive(:call) { true }
        create_list :member, 2, admin: admin
      end

      it { expect { subject }.to change { admin.surveys.count }.by(1) }

      it 'associate survey with admin current members' do
        service.save

        expect(service.survey.members.count).to eq(2)
      end
    end
  end
end
