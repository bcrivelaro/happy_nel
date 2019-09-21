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
      before { create_list :member, 2, admin: admin }
      subject { CreateSurvey.new(admin, valid_params).save }

      it { expect { subject }.to change { admin.surveys.count }.by(1) }
    end
  end
end
