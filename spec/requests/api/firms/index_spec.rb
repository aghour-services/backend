RSpec.describe 'Api::Firms', type: :request do
  let(:firm) { build(:firm) }
  let(:category) { create(:category) }

  describe '#index' do

    before do
      get "/api/firms/?category_id=#{category.id}", params: { tags: "tag" }
    end

    it 'return success response' do
      expect(response.status).to eq 200
    end

  end
end
