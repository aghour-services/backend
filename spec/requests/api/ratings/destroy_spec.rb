RSpec.describe 'Api::RatingsController', type: :request do
  let(:user) { create(:user) }
  let(:rating) { create(:rating, user:) }
  let(:headers) { { TOKEN: user.token } }

  describe '#destroy' do
    context '#success' do
      context 'with authorized user' do
        it 'deletes the rating' do
          delete("/api/firms/#{rating.firm.id}/ratings/#{rating.id}", headers:)
          expect(response).to have_http_status(:no_content)
          expect(Rating.count).to eq(0)
        end
      end
    end

    context '#failure' do
      context 'with unauthorized' do
        let(:headers) { { TOKEN: nil } }

        it 'doesnt delete the rating' do
          delete("/api/firms/#{rating.firm.id}/ratings/#{rating.id}", headers:)

          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end
end
