RSpec.describe 'FirmsController', type: :request do
  let!(:category) {create(:category)}
  let!(:firm) {create(:firm, category:)}

  describe '#index' do
      before do
          get "/categories/#{category.id}/firms"
      end
      it 'returns status code 200' do
          expect(response.status).to eq 200
      end
  end
end
