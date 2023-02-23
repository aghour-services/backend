RSpec.describe 'FirmsController', type: :request do
  let!(:category) {create(:category)}
  let!(:firm) {create(:firm, category:)}

  describe '#new' do
      before do
          get "/categories/#{category.id}/firms/new"
      end
      it 'returns status code 200' do
          expect(response.status).to eq 200
      end
  end
end
