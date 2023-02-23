RSpec.describe 'CategoriesController', type: :request do
  let!(:category) { create(:category) }

  describe "#index" do
    before do
      get '/categories'
    end
    it "returns status code 200" do
      expect(response).to render_template(:index)
      expect(response.status).to eq 200
    end
  end
end
