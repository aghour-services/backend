RSpec.describe 'Api::Comments', type: :request do
  let(:user) { create(:user) }
  let(:article) { build(:article) }
  let(:comment) { build(:comment) }


  describe '#index' do
    it 'returns success with all comments' do
      get "/api/articles/#{article.id}/comments"
      expect(response.status).to eq 200
    end
  end
end