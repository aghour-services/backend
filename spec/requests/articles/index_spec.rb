RSpec.describe 'ArticlesController', type: :request do
  let!(:articles) { create_list(:article, 5, :with_user) }

  describe "#index" do
    before do
      get '/articles'
    end
    it "returns status code 200" do
      expect(response).to render_template(:index)
      expect(response.status).to eq 200
    end
  end
end
