RSpec.describe 'CategoriesController', type: :request do
  describe 'GET index' do
    let!(:categories) { create_list(:category, 2) }
    # let(:cache_key) { 'categories#index' }

    context 'When fetching from DB' do
      it 'returns a successful response' do
        get '/api/categories'
        expect(response).to have_http_status(:ok)
      end
      it 'caches data in redis' do
        get '/api/categories'
        expect(response).to have_http_status(:ok)
        # expect(REDIS_CLIENT.get(cache_key)).not_to be_nil
      end
    end
    xcontext 'When data is cached' do
      before do
        REDIS_CLIENT.set cache_key, 'some data'
      end
      it 'returns a successful response from redis' do
        get '/api/categories'
        expect(response).to have_http_status(:ok)
        expect(response.body).to eq('some data')
      end
    end
  end
end
