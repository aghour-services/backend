RSpec.describe DevicesController, type: :controller do
  let!(:devices) {create_list(:device, 220)}

  describe '#index' do
      before do
          get :index
      end

      it 'returns status code 200 with index template' do
          expect(response).to render_template(:index)
          expect(response.status).to eq 200
      end

      it 'assigns a collection of devices ordered by last_usage_time in descending order and limited to 200' do
          expect(assigns(:devices)).to eq(Device.order(last_usage_time: :desc).limit(200))
      end
  end

end
