RSpec.describe Rating, type: :model do
    let!(:user) { create(:user) }
    let!(:firm) { create(:firm, :with_category) }
  
    let!(:rating) { create(:rating, firm:, user:) }

    context 'validations' do
        it { is_expected.to validate_presence_of(:value) }
        it { is_expected.to validate_inclusion_of(:value).in_range(1..5) }
        it { should validate_uniqueness_of(:firm_id).scoped_to(:user_id) }
    end
  
    context 'relations' do
      it { is_expected.to belong_to(:firm) }
      it { is_expected.to belong_to(:user) }
    end
end
  