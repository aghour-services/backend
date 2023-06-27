RSpec.describe 'UsersController', type: :request do
  let(:user) { create(:user, name: "old name") }

    describe '#create' do
      context '#successful' do
        it 'updates a user' do
         expect{
          user.name="new name"
          user_params = user.attributes.symbolize_keys
          put "/users/#{user.id}", params: { user: user_params  }
         }.to change { user.name }.to('new name')
      end
    end
  end
end
