RSpec.describe Survey, type: :model do
  describe 'associations' do
    it { should belong_to(:admin) }
  end

  describe 'validations' do
    subject { build :survey }

    it { should validate_presence_of(:question) }
    it do
      should define_enum_for(:status).
        with_values(running: 'running', finished: 'finished').
        backed_by_column_of_type(:string)
    end
    it { should validate_presence_of(:members_count) }
    it do
      should validate_numericality_of(:members_count).
        only_integer.
        is_greater_than(0)
    end
    it { should validate_numericality_of(:answer_count).only_integer }
    it { should validate_presence_of(:answer_count) }
    it { should validate_presence_of(:average_rating) }
  end
end
