RSpec.describe Like, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:article) }
  end

  xdescribe "validations" do
    let!(:like) { create(:like) }
    it { should validate_uniqueness_of(:user_id).scoped_to(:article_id) }
  end
end
