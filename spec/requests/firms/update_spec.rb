RSpec.describe 'FirmsController', type: :request do
  let(:category) { create(:category) }
  let(:firm) { create(:firm, category: category,name: "old name") }

    describe '#create' do
      context '#successful' do
        it 'updates a firm' do
         expect{
          firm.name="new name"
          firm_params = firm.attributes.symbolize_keys
          put "/categories/#{category.id}/firms/#{firm.id}", params: { firm: firm_params  }
          expect(response).to have_http_status(:ok)
         }.to change { firm.name }.to('new name')
      end
    end
    context '#failure' do
      it 'doesnt update a firm' do
        firm.name = ''
        firm_params = firm.attributes.symbolize_keys
        put "/categories/#{category.id}/firms/#{firm.id}", params: { firm: firm_params  }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:edit)
      end
    end
  end
end
