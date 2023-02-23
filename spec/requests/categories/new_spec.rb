RSpec.describe 'CategoriesController', type: :request do
  let!(:category) { create(:category) }

  describe "#new" do
    before do
      get '/categories/new'
    end
    it "returns status code 200" do
      expect(response).to render_template(:new)
      expect(response.status).to eq 200
    end
  end
end
