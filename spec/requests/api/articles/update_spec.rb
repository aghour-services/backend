RSpec.describe 'Api::Articles', type: :request do
  let(:user) { create(:user) }
  let(:headers) { { TOKEN: user.token } }

  let(:article) { create(:article, user:, description: 'old desc') }

  describe '#update' do
    context '#success' do
      context 'with authorized usr' do
        context 'with valid parameters' do
          it 'updates the article' do
            expect do
              article.description = 'new desc'
              article_params = article.attributes.symbolize_keys
              put "/api/articles/#{article.id}", params: { article: article_params }, headers: headers
              expect(response).to have_http_status(:ok)
            end.to change { article.description }.to('new desc')
          end
        end
      end
    end

    context '#failure' do
      context 'with unauthorized user and valid params' do
        it 'doesnt create a categories' do
          article_params = article.attributes.symbolize_keys
          put "/api/articles/#{article.id}", params: { article: article_params }

          expect(response).to have_http_status(:unauthorized)
        end
      end

      context 'when authorized user but invalid params' do
        it 'doesnt create a categories' do
          article.description = ''
          article_params = article.attributes.symbolize_keys
          put "/api/articles/#{article.id}", params: { article: article_params }, headers: headers

          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'when user is not the article owner' do
        let(:another_user) { create(:user) }
        let(:headers) { { TOKEN: another_user.token } }

        it 'doesnt create a categories' do
          article_params = article.attributes.symbolize_keys
          put "/api/articles/#{article.id}", params: { article: article_params }, headers: headers

          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end
end
