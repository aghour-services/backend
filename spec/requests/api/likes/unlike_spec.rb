RSpec.describe 'Api::Likes', type: :request do
  let(:user) { create(:user) }
  let(:article) { create(:article, user:) }
  let!(:like) { create(:like, article:, user:) }
  let(:request_headers) { { TOKEN: user.token } }

  xdescribe '#unlike' do
    context '#success' do
      context 'with authorized user' do
        it 'deletes the like' do
          expect do
            delete "/api/articles/#{article.id}/likes/unlike", headers: request_headers
            expect(response).to have_http_status(:no_content)
          end.to change(Like, :count).by(-1)
        end
      end
    end

    context 'when article does not exist' do
      it 'returns a not found error' do
        expect do
          delete '/api/articles/invalid_id/likes/unlike', headers: request_headers
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context '#failure' do
      context 'with unauthorized user' do
        it "don't deletes the like" do
          expect do
            delete "/api/articles/#{article.id}/likes/unlike"
            expect(response).to have_http_status(:unauthorized)
          end.not_to change(Like, :count)
        end
      end
    end
  end
end
