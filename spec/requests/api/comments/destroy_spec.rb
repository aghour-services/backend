RSpec.describe 'Api::Comments', type: :request do

  describe "#destroy" do
    let(:user) { create(:user) }
    let(:article) { create(:article, user:) }
    let(:comment) { create(:comment, article:, user:) }

    it "deletes the comment" do
        headers = { TOKEN: user.token }
        delete "/api/articles/#{article.id}/comments/#{comment.id}", headers: headers
        expect(response.status).to eq(204)
    end
  end
end
