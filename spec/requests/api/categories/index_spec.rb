RSpec.describe 'CategoriesController', type: :request do
  describe 'GET index' do
    let(:categories) { create_list(:category, 2) }

    it 'returns a successful response' do
      get '/api/categories'
      expect(response).to have_http_status(:ok)
    end
  end
end
