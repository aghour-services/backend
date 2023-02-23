RSpec.describe 'FirmsController', type: :request do
  let(:category) { create(:category) }
  let(:firm) { build(:firm, category: category) }

    describe '#create' do
      context '#successful' do
        it 'creates a firm' do
         expect{
          firm_params = firm.attributes.symbolize_keys
          post "/categories/#{category.id}/firms", params: { firm: firm_params  }
         }.to change(Firm, :count).by(1)
      end
    end
    context '#failure' do
      it 'doesnt update a firm' do
        firm.name = ''
        firm_params = firm.attributes.symbolize_keys
        post "/categories/#{category.id}/firms", params: { firm: firm_params  }
        expect(response).to have_http_status(:unprocessable_entity)
        # expect(response).to render_template(:create)
      end
    end
  end
end
