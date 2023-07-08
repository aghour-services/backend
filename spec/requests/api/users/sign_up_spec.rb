RSpec.describe 'Api::Users::RegistrationsController', type: :request do
  describe '#sign_up' do
    let(:avatar) { fixture_file_upload('spec/fixture_files/1.jpeg', 'image/png') }

    let(:imgur_response) do
      '{"data":{"id":"3O9qUDG", "type":"image/png"}, "success": true}'
    end
    let(:request_body) do
      {
        name: 'UserName',
        email: 'user@example.com',
        mobile: '0123412312',
        password: 'password',
        avatar:
      }
    end

    let(:response_body) do
      {
        id: 2,
        name: 'UserName',
        email: 'user@example.com',
        mobile: '0123412312',
        url: nil,
        verified: false,
        token: 'token'
      }
    end

    before do
      stub_request(:post, 'https://api.imgur.com/3/upload.json')
        .to_return(body: imgur_response,
                   headers: { "Content-Type": 'application/json' })
    end

    context 'with valid params' do
      it 'creates a new user' do
        expect do
          post '/api/users', params: { user: request_body }
        end.to change { User.count }.by(1)
        recent_user = User.last

        expect(response).to have_http_status(201)
        expected_response = response_body.merge(id: recent_user.id, token: recent_user.token)
        expect(response.body).to eq(expected_response.to_json)
      end
    end

    context 'with invalid params' do
      let(:invalid_params) { { email: '', password: '' } }

      it 'does not create a new user' do
        expect do
          post '/api/users', params: { user: invalid_params }
        end.to change { User.count }.by(0)
      end
    end

    context 'without avatar picture' do
      let(:params_without_avatar) do
        {
          email: 'user2@example.com',
          mobile: '0123412312',
          name: 'UserName',
          password: 'password'
        }
      end

      it 'creates a new user with no profile pic' do
        expect do
          post '/api/users', params: { user: params_without_avatar }
        end.to change { User.count }.by(1)
      end
    end

    context 'when imgur response is false' do
      let(:imgur_response) do
        '{"data":{"id":"3O9qUDG", "type":"image/png"}, "success": false}'
      end

      it 'does not create a new user (Rollback)' do
        expect do
          post '/api/users', params: { user: request_body }
        end.to change { User.count }.by(0)
        change { User.count }.by(0)

        expect(response).to have_http_status(422)
        expect(User.last).to be_nil
      end
    end
  end
end
