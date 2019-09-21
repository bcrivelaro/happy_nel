RSpec.describe Admin, type: :model do
  describe 'associations' do
    it { should have_many(:members) }
    it { should have_many(:surveys) }
  end

  describe '#can_create_survey?' do
    let(:admin) { create :admin }

    subject { admin.can_create_survey? }

    context 'when have members' do
      before { create :member, admin: admin }

      it { is_expected.to eq(true) }
    end

    context 'when have no members' do
      it { is_expected.to eq(false) }
    end
  end
end
