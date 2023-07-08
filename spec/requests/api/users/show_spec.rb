RSpec.describe "Api::Users", type: :request do
    let(:user) { create(:user) }
  
    describe "#show" do
      it "returns success response" do
        get "/api/users/#{user.id}"
        expect(response).to have_http_status(:ok)
      end
    end
end
  