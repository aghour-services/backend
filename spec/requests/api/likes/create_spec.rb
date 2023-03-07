RSpec.describe "Api::Likes", type: :request do
  let(:user) {create(:user)}
  let(:article) { create(:article , user:) }
  let(:headers) { { TOKEN: user.token } }
  describe '#create' do
    context '#success' do
        it "creates like to article" do
            expect {
                post "/api/articles/#{article.id}/likes", headers: headers
            }.to change(Like, :count).by(1)
            expect(response.status).to eq(200)
        end
    end
    context "#failure" do
      it "creates like to article" do
          post "/api/articles/#{article.id}/likes"
          expect(response.status).to eq(401)
      end
    end
  end
end
