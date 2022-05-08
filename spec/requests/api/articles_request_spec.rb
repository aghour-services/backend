RSpec.fdescribe 'Api::Articles', type: :request do
  context '#create' do
    context 'When default user' do
      let(:user) { create(:user) }
      let(:article) { build(:article) }
      it 'creates draft article' do
        headers = { TOKEN: user.token }
        expect do
          post '/api/articles', params: { article: { description: article.description } }, headers: headers
        end.to change { Article.count }.by(1)
        expect(Article.last.status.to_s).to eq('draft')
      end
    end

    context 'When publisher user' do
      let(:user) { create(:user, :publisher) }
      let(:article) { build(:article) }
      it 'creates published article' do
        headers = { TOKEN: user.token }
        expect do
          post '/api/articles', params: { article: { description: article.description } }, headers: headers
        end.to change { Article.count }.by(1)
        expect(Article.last.status.to_s).to eq('published')
      end
    end

    context 'creates published articles' do
      let(:user) { create(:user, :admin) }
      let(:article) { build(:article) }
      it 'creates published articles' do
        headers = { TOKEN: user.token }
        expect do
          post '/api/articles', params: { article: { description: article.description } }, headers: headers
        end.to change { Article.count }.by(1)
        expect(Article.last.status.to_s).to eq('published')
      end
    end
  end
end
