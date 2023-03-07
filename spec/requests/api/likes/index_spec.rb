RSpec.describe "Api::Likes", type: :request do
    let(:article) { create(:article, :with_user) }

    describe '#index' do
        context '#success' do
            it "show liked users" do
                get "/api/articles/#{article.id}/likes"
                expect(response.status).to eq(200)
            end
        end
    end
end
