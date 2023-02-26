
RSpec.describe 'UsersController', type: :request do
 let!(:user) {create(:user)}
  describe '#index' do
      before do
          get "/users"
      end
      it 'returns status code 200' do
          expect(response.status).to eq 200
      end
  end
end
