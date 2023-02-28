RSpec.describe "Api::Searches", type: :request do
  let(:firm) { create(:firm, :with_category) }

  describe "#index" do
    before do
      get "/api/search", params: { keyword: firm.name }
    end

    it "returns success response" do
      expect(response).to have_http_status(:success)
    end

    it "returns results with search params" do
      expect(assigns(:results)).to include(firm)
    end
  end
end
