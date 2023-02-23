RSpec.describe 'FirmsController', type: :request do
  let!(:category) {create(:category)}
  let!(:firm) {create(:firm, category:)}

  describe '#destroy' do
      before do
        delete "/categories/#{category.id}/firms/#{firm.id}"
      end
      it "deletes the source page" do
        expect(Firm.find_by(id: firm.id)).to be_nil
        expect(response).to redirect_to(firms_path)
    end
  end
end
