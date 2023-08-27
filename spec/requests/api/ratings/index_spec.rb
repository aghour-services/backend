RSpec.describe 'Api::RatingsController', type: :request do
  describe '#index' do
    let!(:rating) { create(:rating) }

    it 'returns a successful response' do
      get "/api/firms/#{rating.firm.id}/ratings"
      expect(response).to have_http_status(:ok)
    end
  end
end
