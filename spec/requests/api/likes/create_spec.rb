RSpec.describe "Api::Likes", type: :request do
  let(:user) {create(:user)}
  let(:article) { create(:article , user:) }
  let(:headers) { { TOKEN: user.token } }

  describe "#create" do
    context "when article exists" do
      it "creates a new like for the current user and article" do
        expect {
          post "/api/articles/#{article.id}/likes", headers: headers
        }.to change(Like, :count).by(1)
        expect(response).to have_http_status(:ok)
        expect(response.body).to eq(article.likes.count.to_s)
      end
    end

    context "when article does not exist" do
      it "returns a not found error" do
        post "/api/articles/invalid_id/likes", headers: headers
        expect(response).to have_http_status(:not_found)
        expect(response.body).to eq({ error: "Article not found" }.to_json)
      end
    end

    context "when current_user doesn't exist" do
      it "returns unauthorized error" do
        post "/api/articles/#{article.id}/likes"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
