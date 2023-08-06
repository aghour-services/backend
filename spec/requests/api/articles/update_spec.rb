RSpec.describe 'Api::Articles', type: :request do
  let(:user) { create(:user) }
  let(:headers) { { TOKEN: user.token } }
  let(:article) { create(:article, user:, description: 'old desc') }
  let(:attachment) { fixture_file_upload('spec/fixture_files/1.jpeg', 'image/png') }

  let(:imgur_response) do
    '{"data":{"id":"3O9qUDG", "type":"image/png"}, "success": true}'
  end

  describe '#update' do
    before do
      stub_request(:post, 'https://api.imgur.com/3/upload.json')
        .to_return(body: imgur_response,
                   headers: { "Content-Type": 'application/json' })
    end

    context '#success' do
      context 'with authorized usr' do
        context 'with valid parameters' do
          it 'updates the article' do
            expect do
              article.description = 'new desc'
              article_params = article.attributes.symbolize_keys
              put("/api/articles/#{article.id}", params: { article: article_params.merge(attachment:) },
                                                 headers:)
              expect(response).to have_http_status(:ok)
            end.to change { article.description }.to('new desc')
          end

          it 'updates the article with attachment' do
            expect do
              article.description = 'new desc'
              article_params = article.attributes.symbolize_keys
              put("/api/articles/#{article.id}", params: { article: article_params.merge(attachment:) },
                                                 headers:)
              expect(response).to have_http_status(:ok)
            end.to change { Attachment.count }.by(1)
          end
        end
      end

      context 'with user is admin' do
        context 'with valid parameters' do
          let(:admin_user) { create(:user, role: :admin) }
          let(:headers) { { TOKEN: admin_user.token } }
          it 'updates the article' do
            expect do
              article.description = 'new desc'
              article_params = article.attributes.symbolize_keys
              put("/api/articles/#{article.id}", params: { article: article_params.merge(attachment:) },
                                                 headers:)
              expect(response).to have_http_status(:ok)
            end.to change { article.description }.to('new desc')
          end

          it 'updates the article with attachment' do
            expect do
              article.description = 'new desc'
              article_params = article.attributes.symbolize_keys
              put("/api/articles/#{article.id}", params: { article: article_params.merge(attachment:) },
                                                 headers:)
              expect(response).to have_http_status(:ok)
            end.to change { Attachment.count }.by(1)
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
          put("/api/articles/#{article.id}", params: { article: article_params }, headers:)

          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'when user is not the article owner' do
        let(:another_user) { create(:user) }
        let(:headers) { { TOKEN: another_user.token } }

        it 'doesnt create a categories' do
          article_params = article.attributes.symbolize_keys
          put("/api/articles/#{article.id}", params: { article: article_params }, headers:)

          expect(response).to have_http_status(:unauthorized)
        end
      end

      context 'when imgur response is false' do
        let(:imgur_response) do
          '{"data":{"id":"3O9qUDG", "type":"image/png"}, "success": false}'
        end

        it 'doesnt update an article and Rollback' do
          article.description = 'new description'
          article_params = article.attributes.symbolize_keys
          put("/api/articles/#{article.id}", params: { article: article_params.merge(attachment:) },
                                             headers:)

          expect(Article.last.description).to eq('old desc')
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
end
