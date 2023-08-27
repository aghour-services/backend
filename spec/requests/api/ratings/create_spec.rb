RSpec.describe 'Api::RatingsController', type: :request do
  let(:user) { create(:user) }
  let(:firm) { create(:firm, :with_category) }
  let(:headers) { { TOKEN: user.token } }

  describe '#create' do
    context 'when firm exists' do
      it 'creates a new rating' do
        expect do
          post("/api/firms/#{firm.id}/ratings", params: { rating: { value: 4, comment: 'very good' } },
                                                headers:)
          expect(response).to have_http_status(:created)
          expect(firm.ratings.count).to eq(1)
        end.to change(Rating, :count).by(1)
      end
    end

    context 'when user does not exist' do
      let(:headers) { { TOKEN: nil } }

      it 'returns unauthorized status' do
        expect do
          post("/api/firms/#{firm.id}/ratings", params: { rating: { value: 4, comment: 'very good' } },
                                                headers:)
          expect(response).to have_http_status(:unauthorized)
          expect(firm.ratings.count).to eq(0)
        end.to change(Rating, :count).by(0)
      end
    end

    context 'invalid params' do
      it 'returns unprocessable_entity status' do
        expect do
          post("/api/firms/#{firm.id}/ratings", params: { rating: { value: nil } }, headers:)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(firm.ratings.count).to eq(0)
        end.to change(Rating, :count).by(0)
      end
    end
  end
end
