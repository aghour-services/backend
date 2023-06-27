RSpec.describe 'Api::Users::RegistrationsController', type: :request do
  describe '#sign_up' do
    let(:avatar) { fixture_file_upload('spec/fixture_files/1.jpeg', 'image/png') }

    let(:imgur_response) do
      '{"data":{"id":"3O9qUDG", "type":"image/png"}, "success": true}'
    end
    let(:valid_params) do
      {
        email: 'user@example.com',
        mobile: '0123412312',
        name: 'UserName',
        password: 'password',
        avatar:
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
          post '/api/users', params: { user: valid_params }
        end.to change { User.count }.by(1)
      end

      it 'returns a 201 status code' do
        post '/api/users', params: { user: valid_params }
        expect(response).to have_http_status(201)
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
          post '/api/users', params: { user: valid_params }
        end.to change { User.count }.by(0)
        change { User.count }.by(0)

        expect(response).to have_http_status(422)
        expect(User.last).to be_nil
      end
    end
  end
end
