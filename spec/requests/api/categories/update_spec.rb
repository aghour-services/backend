RSpec.describe "CategoriesController", type: :request do
  let(:category) { create(:category, name: "old name") }

  describe "#update" do
    context "#successful" do
      it "creates a category" do
        expect do
          category.name = "new name"
          category_params = category.attributes.symbolize_keys
          put "/categories/#{category.id}", params: { category: category_params }
          expect(response).to have_http_status(:ok)
        end.to change { category.name }.to("new name")
      end
    end

    context "#failure" do
      it "doesnt create a categories" do
        category.name = ""
        category_params = category.attributes.symbolize_keys
        put "/categories/#{category.id}", params: { category: category_params }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:edit)
      end
    end
  end
end
