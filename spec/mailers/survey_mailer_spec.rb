RSpec.describe SurveyMailer, type: :mailer do
  before :each do
    ENV['HOST'] = 'localhost:3000'
  end
  after :each do
    ENV['HOST'] = nil
  end

  describe '#notify_member' do
    let(:member) { create :member }
    let(:survey_token) { create :survey_token }
    let(:mail) { SurveyMailer.notify_member(member, survey_token).deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq(I18n.t('survey_mailer.notify_member.subject'))
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([member.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['bcrivelaro-happy-nel@email.com'])
    end

    it 'renders answer link' do
      expect(mail.body.encoded)
        .to include("http://localhost:3000/answer?token=#{survey_token.token}")
    end
  end

  describe '#finished_survey' do
    let(:member) { create :member }
    let(:survey) { create :survey, status: :finished }
    let(:mail) { SurveyMailer.finished_survey(member, survey).deliver_now }

    it 'renders the subject' do
      expect(mail.subject)
        .to eq(I18n.t('survey_mailer.finished_survey.subject'))
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([member.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['bcrivelaro-happy-nel@email.com'])
    end

    it 'renders survey average' do
      expect(mail.body.encoded).to include(survey.average_rating.to_s)
    end
  end
end
