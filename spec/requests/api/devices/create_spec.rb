RSpec.describe Api::DevicesController, type: :request do
  let!(:user) { create(:user) }
  let!(:device) { build(:device) }

  describe "POST /api/devices" do
    context 'When invalid user' do
      it 'returns unauthorized status' do
        headers = { TOKEN: Faker::Name.name }

        post '/api/devices', params: { token: device.token }, headers: headers
        expect(response.status).to eq(201)
        expect(json_response['token']).to eq(device.token)
        expect(json_response['user_id']).to eq(nil)
      end
    end

    context 'When authenticated user' do

      it 'creates a device' do
        headers = { TOKEN: user.token }
        expect do
          post '/api/devices', params: { token: device.token }, headers: headers
        end.to change { Device.count }.by(1)

        expect(response.status).to eq(201)
        expect(json_response['token']).to eq(device.token)
        expect(json_response['user_id']).to eq(user.id)
      end
    end
  end

  def json_response
    JSON.parse(response.body)
  end
end