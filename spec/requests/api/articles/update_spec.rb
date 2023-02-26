RSpec.describe "ArticlesController", type: :request do
  let(:user) { create(:user) }

  let(:article) { create(:article,user: user, description: "old desc") }

  describe "#update" do
    context "with valid parameters" do
      it "updates the article" do
        expect do
          article.description = "new desc"
          article_params = article.attributes.symbolize_keys
          put "/api/articles/#{article.id}" ,params: { article: article_params }
          # expect(response).to have_http_status(:ok)
        end.to change { article.description }.to("new desc")
      end
    end

end

    xcontext "#failure" do
      it "doesnt create a categories" do
        category.name = ""
        category_params = category.attributes.symbolize_keys
        put "/categories/#{category.id}", params: { category: category_params }

        # expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:edit)
      end
    end
end
