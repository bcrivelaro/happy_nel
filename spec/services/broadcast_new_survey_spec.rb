RSpec.describe BroadcastNewSurvey do
  let(:admin) { create :admin }
  let(:members) { create_list :member, 2, admin: admin }
  let(:survey) { create :survey, admin: admin, members: members }

  describe '.call' do
    subject { BroadcastNewSurvey.call(survey) }

    it { expect { subject }.to change { SurveyToken.count }.by(2) }
    it { expect { subject }.to change { Sidekiq::Worker.jobs.size }.by(2) }
  end
end