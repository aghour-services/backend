RSpec.describe 'ArticlesController', type: :request do
  describe 'GET index' do
    let(:articles) { create_list(:article, 4) }

    it 'returns a successful response' do
      get '/api/articles/draft'
      expect(response).to have_http_status(:ok)
    end
  end
end
