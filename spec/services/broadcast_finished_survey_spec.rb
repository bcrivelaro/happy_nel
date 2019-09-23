RSpec.describe BroadcastFinishedSurvey do
  let(:admin) { create :admin }
  let(:members) { create_list :member, 2, admin: admin }
  let(:survey) do
    create :survey, status: :running, admin: admin, members: members
  end

  describe '.call' do
    subject { BroadcastFinishedSurvey.call(survey) }

    it { expect { subject }.to change { survey.status }.to('finished') }
    it { expect { subject }.to change { Sidekiq::Worker.jobs.size }.by(2) }
  end
end
