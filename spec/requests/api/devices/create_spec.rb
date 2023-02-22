RSpec.describe Api::DevicesController, type: :controller do
  let(:test_token) { "test_token" }

  describe "POST /api/devices/create" do
    context "with valid parameters" do
      it "creates a new device" do
        expect { post :create, params: { token: test_token } }.to change(Device, :count).by(1)
      end

      it "returns created device" do
        post :create, params: { token: test_token }
        expect(response.status).to eq 201
      end
    end

    context "with invalid parameters" do
      it "returns Bad Request error" do
        post :create, params: { token: nil }
        expect(response.status).to eq 204
      end
    end
  end
end
