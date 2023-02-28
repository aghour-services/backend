RSpec.describe "UsersController", type: :request do
  let!(:user) { create(:user) }

  describe "#destroy" do
    before do
      delete "/users/#{user.id}"
    end

    it "deletes the user" do
      expect(User.exists?(user.id)).to be_falsey
    end

    it "redirects to the users index page" do
      expect(response).to redirect_to(users_path)
    end
  end
end
