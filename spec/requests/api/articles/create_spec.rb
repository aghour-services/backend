# frozen_string_literal: true

RSpec.describe 'Api::Articles', type: :request do
  context '#create' do
    let(:user) { create(:user) }
    let(:article) { build(:article) }
    let(:attachment) { fixture_file_upload('spec/fixture_files/1.jpeg', 'image/png') }

    let(:imgur_response) do
      '{"data":{"id":"3O9qUDG", "type":"image/png"}, "success": true}'
    end

    before do
      stub_request(:post, 'https://api.imgur.com/3/upload.json')
        .to_return(body: imgur_response,
                   headers: { "Content-Type": 'application/json' })

      stub_request(:post, 'https://www.googleapis.com/oauth2/v4/token')
    end

    context 'When invalid user' do
      it 'creates draft article' do
        headers = { TOKEN: Faker::Name.name }

        post '/api/articles', params: { article: { description: article.description } }, headers: headers
        expect(response.status).to eq(401)
      end
    end

    context 'When default user' do
      it 'creates draft article' do
        headers = { TOKEN: user.token }
        expect do
          post '/api/articles', params: { article: { description: article.description, attachment: } }, headers:
        end.to change { Article.count }.by(1)
        expect(Article.last.status.to_s).to eq('draft')
        change { Article.last.attachments.count }.by(1)
      end
    end

    context 'When publisher user' do
      let(:user) { create(:user, :publisher) }
      it 'creates published article' do
        headers = { TOKEN: user.token }
        expect do
          post '/api/articles', params: { article: { description: article.description, attachment: } }, headers:
        end.to change { Article.count }.by(1)
        expect(Article.last.status.to_s).to eq('published')
        change { Article.last.attachments.count }.by(1)
      end
    end

    context 'creates published articles' do
      let(:user) { create(:user, :admin) }
      it 'creates published articles' do
        headers = { TOKEN: user.token }
        expect do
          post '/api/articles', params: { article: { description: article.description, attachment: } }, headers:
        end.to change { Article.count }.by(1)
        expect(Article.last.status.to_s).to eq('published')
        change { Article.last.attachments.count }.by(1)
      end
    end

    context 'when imgur response is false' do
      let(:user) { create(:user, :admin) }
      let(:imgur_response) do
        '{"data":{"id":"3O9qUDG", "type":"image/png"}, "success": false}'
      end
      it 'creates published articles' do
        headers = { TOKEN: user.token }
        expect do
          post '/api/articles', params: { article: { description: article.description, attachment: } }, headers:
        end.to change { Article.count }.by(0)
        change { Attachment.count }.by(0)
      end
    end
  end
end
