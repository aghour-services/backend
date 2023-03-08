RSpec.describe 'Api::Likes', type: :request do
    let(:user) { create(:user) }
    let(:article) { create(:article, user:) }
    let!(:like) {create(:like, article:, user:)}
    let(:headers) {{TOKEN: user.token}}

    describe '#destroy' do
      context '#success' do
        context 'with authorized user' do
          it 'deletes the like' do
            delete "/api/articles/#{article.id}/likes/unlike", headers: headers
            expect(response).to have_http_status(:ok)
            expect(Like.count).to eq(0)
          end
        end
      end

      context "when article does not exist" do
        it "returns a not found error" do
          delete "/api/articles/invalid_id/likes/unlike", headers: headers
          expect(response).to have_http_status(:not_found)
          expect(response.body).to eq({ error: "Article not found or not liked by user" }.to_json)
        end
      end

      context "#failure" do
        context "with unauthorized user" do
          it "don't deletes the like" do
            delete "/api/articles/#{article.id}/likes/unlike"
            expect(response).to have_http_status(:unauthorized)
            expect(Like.count).to eq(1)
          end
        end
      end
    end
  end
