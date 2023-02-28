RSpec.describe "Api::Users", type: :request do
  let(:user) { create(:user) }

  describe "#sign_in" do
    context "#success" do
      before { post "/api/users/sign_in", params: { user: { email: user.email, password: user.password } } }

      it "generates a new authentication token for the user" do
        expect(user.reload.token).not_to be_nil
      end

      it "returns 200 status code" do
        expect(response.status).to eq 200
      end
    end

    context "#failure" do
      before { post "/api/users/sign_in", params: { user: { email: user.email, password: "invalid" } } }
      it "returns 401 unauthorized status code" do
        expect(response.status).to eq 401
      end
    end
  end
end
