RSpec.describe UpdateSurveyAverage do
  let(:members) { create_list :member, 2 }
  let(:survey) do
    create :survey, status: :running, members: members, answer_count: 1,
                    average_rating: 7
  end
  let(:survey_token) { create :survey_token, survey: survey }
  let(:answer) { '8' }

  describe '.call' do
    context 'invalid token' do
      subject { UpdateSurveyAverage.call('invalid', answer) }

      it { is_expected.to be_nil }
    end

    context 'valid token and finish survey' do
      subject { UpdateSurveyAverage.call(survey_token.token, answer) }

      it do
        expect do
          subject
        end.to change { survey.reload.answer_count }.from(1).to(2)
      end
      it do
        expect do
          subject
        end.to change { survey.reload.average_rating }.from(7).to(7.5)
      end
      it { expect { subject }.to change { Sidekiq::Worker.jobs.size }.by(1) }
    end

    context 'valid token and not finished survey' do
      let(:members) { create_list :member, 2 }
      let(:survey) do
        create :survey, status: :running, members: members, answer_count: 0,
                        average_rating: 0
      end
      let(:survey_token) { create :survey_token, survey: survey }
      let(:answer) { '8' }

      subject { UpdateSurveyAverage.call(survey_token.token, answer) }

      it do
        expect do
          subject
        end.to change { survey.reload.answer_count }.from(0).to(1)
      end
      it do
        expect do
          subject
        end.to change { survey.reload.average_rating }.from(0).to(8)
      end
      it { expect { subject }.to change { Sidekiq::Worker.jobs.size }.by(0) }
    end
  end
end
