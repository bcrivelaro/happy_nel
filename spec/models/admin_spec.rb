RSpec.describe Admin, type: :model do
  describe 'associations' do
    it { should have_many(:members) }
  end
end
