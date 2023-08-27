RSpec.describe 'Api::RatingsController', type: :request do
  let(:user) { create(:user) }
  let(:rating) { create(:rating, user:, value: 2) }
  let(:headers) { { TOKEN: user.token } }

  describe '#update' do
    context 'with authorized user and valid params' do
      it 'updates an exist rating' do
        expect do
          rating.value = 3
          rating_params = rating.attributes.symbolize_keys
          put("/api/firms/#{rating.firm.id}/ratings/#{rating.id}", params: { rating: rating_params }, headers:)
          expect(response).to have_http_status(:ok)
        end.to change { rating.value }.to(3)
      end
    end

    context 'when user does not exist' do
      let(:headers) { { TOKEN: nil } }

      it 'returns unauthorized status' do
        expect do
          rating.value = 1
          rating_params = rating.attributes.symbolize_keys
          put("/api/firms/#{rating.firm.id}/ratings/#{rating.id}", params: { rating: rating_params }, headers:)
          expect(response).to have_http_status(:unauthorized)
        end.not_to(change { rating.reload.value })
      end
    end

    context 'invalid params' do
      it 'returns unprocessable_entity status' do
        expect do
          rating.value = 6
          rating_params = rating.attributes.symbolize_keys
          put("/api/firms/#{rating.firm.id}/ratings/#{rating.id}", params: { rating: rating_params }, headers:)
          expect(response).to have_http_status(:unprocessable_entity)
        end.not_to(change { rating.reload.value })
      end
    end
  end
end
