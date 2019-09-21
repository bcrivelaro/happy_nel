RSpec.describe Member, type: :model do
  describe 'associations' do
    it { should belong_to(:admin) }
  end

  describe 'validations' do
    subject { build :member }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).scoped_to(:admin_id) }
  end
end
