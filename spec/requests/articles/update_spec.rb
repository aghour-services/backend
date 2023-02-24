RSpec.describe "articlesController", type: :request do
  let(:article) { create(:article,:with_user, description: "old desc") }

  describe "#update" do
    context "#successful" do
      it "update an article desc" do
        expect do
          article.description = "new desc"
          article_params = article.attributes.symbolize_keys
          put "/articles/#{article.id}", params: { article: article_params }
          # expect(response).to have_http_status(:ok)
        end.to change { article.description }.to("new desc")
      end
    end
  end
end
