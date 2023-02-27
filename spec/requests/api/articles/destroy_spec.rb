RSpec.describe 'Api::Articles', type: :request do
  let(:user) { create(:user) }
  let(:headers) { { TOKEN: user.token } }
  let(:article) { create(:article, user:) }

  describe '#destroy' do
    context '#success' do
      context 'with authorized user' do
        it 'deletes the article' do
          delete "/api/articles/#{article.id}", headers: headers
          expect(response).to have_http_status(:no_content)
          expect(Article.count).to eq(0)
        end
      end
    end

    context '#failure' do
      context 'with unauthorized' do
        it 'doesnt delete the article' do
          delete "/api/articles/#{article.id}"

          expect(response).to have_http_status(:unauthorized)
        end
      end
      context 'when user is not the article owner' do
        let(:another_user) { create(:user) }
        let(:headers) { { TOKEN: another_user.token } }

        it 'doesnt delete the article' do
          delete "/api/articles/#{article.id}", headers: headers
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end
end
