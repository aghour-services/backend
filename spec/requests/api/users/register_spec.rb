RSpec.describe "Api::Users::RegistrationsController", type: :request do
  describe "#sign_up" do
    context "with valid params" do
      let(:valid_params) do
        {
          email: "user@example.com",
          mobile: "0123412312",
          name: "UserName",
          password: "password",
        }
      end

      it "creates a new user" do
        expect {
          post "/api/users", params: { user: valid_params }
        }.to change { User.count }.by(1)
      end

      it "returns a 201 status code" do
        post "/api/users", params: { user: valid_params }
        expect(response).to have_http_status(201)
      end
    end

    context "with invalid params" do
      let(:invalid_params) { { email: "", password: "" } }

      it "does not create a new user" do
        expect {
          post "/api/users", params: { user: invalid_params }
        }.not_to change(User, :count)
      end

      it "returns a 422 status code" do
        post "/api/users", params: { user: invalid_params }
        expect(response).to have_http_status(422)
      end
    end
  end
end
