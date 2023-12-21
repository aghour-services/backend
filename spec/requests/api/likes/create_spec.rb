RSpec.describe 'Api::Likes', type: :request do
  let(:user) { create(:user) }
  let(:article) { create(:article, user:) }
  let(:request_headers) { { TOKEN: user.token } }

  xdescribe '#create' do
    context 'when article exists' do
      it 'creates a new like for the current user and article' do
        expect do
          post "/api/articles/#{article.id}/likes", headers: request_headers
          expect(response).to have_http_status(:ok)
          expect(response.body).to eq(article.likes.count.to_s)
        end.to change(Like, :count).by(1)
      end
    end

    context 'when article does not exist' do
      it 'returns a not found error' do
        expect do
          post('/api/articles/invalid_id/likes', headers: request_headers)
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "when current_user doesn't exist" do
      it 'returns unauthorized error' do
        expect do
          post "/api/articles/#{article.id}/likes"
          expect(response).to have_http_status(:unauthorized)
        end.not_to change(Like, :count)
      end
    end
  end
end
