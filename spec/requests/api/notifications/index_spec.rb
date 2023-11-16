RSpec.describe 'Api::Notifications', type: :request do
  let(:article) { create(:article, :with_user) }
  let(:notification) { create(:notification, notifiable: article, user: article.user) }

  describe '#index' do
    context '#success' do
      it 'show notifications' do
        get "/api/notifications"
        expect(response.status).to eq(200)
      end
    end
  end
end
