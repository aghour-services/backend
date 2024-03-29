RSpec.describe "Api::Users", type: :request do
  let(:user) { create(:user) }
  let(:headers) { { TOKEN: user.token } }

  describe "#profile" do
    it "returns success response" do
      get "/api/users/profile", headers: headers
      expect(response).to have_http_status(:ok)
    end

    it "returns unauthorized response" do
      get "/api/users/profile"
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
