RSpec.describe 'Api::Likes', type: :request do
  let(:user) { create(:user) }
  let(:article) { create(:article, user:) }
  let(:like) {create(:like, article:, user:)}
  let(:headers) {{TOKEN: user.token}}

  describe '#destroy' do
    context '#success' do
      context 'with authorized user' do
        it 'deletes the like' do
          delete "/api/articles/#{article.id}/likes/#{like.id}", headers: headers
          expect(response).to have_http_status(:ok)
          expect(Like.count).to eq(0)
        end
      end
    end


    context "#failure" do
      context "with unauthorized user" do
        it "don't deletes the like" do
          delete "/api/articles/#{article.id}/likes/#{like.id}"
          expect(response).to have_http_status(:unauthorized)
          expect(Like.count).to eq(1)
        end
      end
    end
  end
end
