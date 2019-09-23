RSpec.describe AnswersController, type: :request do
  describe 'GET #new' do
    context 'valid token' do
      let(:survey_token) { create :survey_token }

      before { get answer_path(token: survey_token.token) }

      it { expect(response).to be_successful }
      it { expect(assigns(:survey_token)).to eq(survey_token) }
    end

    context 'used token' do
      let(:survey_token) { create :survey_token, used_at: 1.day.ago }

      before { get answer_path(token: survey_token.token) }

      it { expect(response).to redirect_to('https://www.google.com') }
    end

    context 'invalid token' do
      before { get answer_path(token: 'invalid') }

      it { expect(response).to redirect_to('https://www.google.com') }
    end
  end

  describe 'POST #create' do
    context 'valid params' do
      let(:survey_token) { create :survey_token }
      let(:params) { { token: survey_token.token, answer: '8' } }

      subject { post answer_path(params) }

      it do
        expect do
          subject
        end.to change { survey_token.reload.used_at.present? }.from(false)
                                                              .to(true)
      end
      it { is_expected.to redirect_to(thank_you_path) }
      it { expect { subject }.to change { Sidekiq::Worker.jobs.size}.by(1) }
    end

    context 'used token' do
      let(:survey_token) { create :survey_token, used_at: 1.day.ago }
      let(:params) { { token: survey_token.token, answer: '8' } }

      before { post answer_path(token: survey_token.token) }

      it { expect(response).to redirect_to('https://www.google.com') }
    end

    context 'invalid token' do
      let(:params) { { token:'invalid', answer: '8' } }
      before { post answer_path(params) }

      it { expect(response).to redirect_to('https://www.google.com') }
    end

    context 'invalid answer' do
      let(:survey_token) { create :survey_token }
      let(:params) { { token: survey_token.token, answer: nil } }

      before { post answer_path(token: survey_token.token) }

      it { expect(response).to redirect_to('https://www.google.com') }
    end
  end

  describe 'GET #thank_you' do
    before { get thank_you_path }

    it { expect(response).to be_successful }
  end
end