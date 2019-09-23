RSpec.describe Survey, type: :model do
  describe 'associations' do
    it { should belong_to(:admin) }
    it { should have_many(:survey_tokens) }
    it { should have_and_belong_to_many(:members) }
  end

  describe 'validations' do
    subject { build :survey }

    it { should validate_presence_of(:question) }
    it do
      should define_enum_for(:status).
        with_values(running: 'running', finished: 'finished').
        backed_by_column_of_type(:string)
    end
    it { should validate_numericality_of(:answer_count).only_integer }
    it { should validate_presence_of(:answer_count) }
    it { should validate_presence_of(:average_rating) }
  end
end
