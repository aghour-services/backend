RSpec.describe 'Api::Firms', type: :request do
  context '#create' do
    let(:firm) { build(:firm) }
    let(:category) { create(:category) }

    context 'When default user' do
      let(:user) { create(:user) }

      it 'creates draft firm' do
        headers = { TOKEN: user.token }
        firm_params = { firm: firm.attributes.merge(category_id: category.id) }
        expect do
          post '/api/firms', params: firm_params, headers:
        end.to change { Firm.count }.by(1)
        expect(Firm.last.status.to_s).to eq('draft')
      end
    end

    context 'When publisher user' do
      let(:user) { create(:user, :publisher) }
      it 'creates published firm' do
        headers = { TOKEN: user.token }
        firm_params = { firm: firm.attributes.merge(category_id: category.id) }
        expect do
          post '/api/firms', params: firm_params, headers:
        end.to change { Firm.count }.by(1)
        expect(Firm.last.status.to_s).to eq('published')
      end
    end

    context 'creates published firm' do
      let(:user) { create(:user, :admin) }
      it 'creates published firms' do
        headers = { TOKEN: user.token }
        firm_params = { firm: firm.attributes.merge(category_id: category.id) }
        expect do
          post '/api/firms', params: firm_params, headers:
        end.to change { Firm.count }.by(1)
        expect(Firm.last.status.to_s).to eq('published')
      end
    end

    context "doesn't create firm" do
      let(:user) { create(:user) }
      it "doesn't published firms" do
        headers = { TOKEN: user.token }
        firm_params = { firm: firm.attributes }
        expect do
          post '/api/firms', params: firm_params, headers:
        end.to change { Firm.count }.by(0)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
