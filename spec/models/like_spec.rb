RSpec.describe Like, type: :model do
  let!(:user) { create(:user) }
  let!(:article) { create(:article, user:) }

  let!(:like) { create(:like, user: ,article:) }
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:article) }
  end

  describe "validations" do
    it { should validate_uniqueness_of(:user_id).scoped_to(:article_id) }
  end
end
