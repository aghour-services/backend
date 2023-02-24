RSpec.describe "ArticlesController", type: :request do
  let(:article) { create(:article,:with_user, description: "old desc") }

  describe "#update" do
    context "with valid parameters" do
      it "updates the article" do
        article.update(description: "new desc")
        article_params = article.attributes.symbolize_keys
        put "/api/articles/#{article.id}", params: { article: article_params }
        article.reload
        expect(article.description).to eq("new desc")
        # expect(response).to have_http_status(:ok)
      end
    end

end

    xcontext "#failure" do
      it "doesnt create a categories" do
        category.name = ""
        category_params = category.attributes.symbolize_keys
        put "/categories/#{category.id}", params: { category: category_params }

        expect(response).to have_http_status(:unprocessable_entity)
        # expect(response).to render_template(:edit)
      end
    end
end
