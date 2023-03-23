# frozen_string_literal: true

RSpec.describe 'Api::Articles', type: :request do
  context '#create' do
    let(:user) { create(:user) }
    let(:article) { build(:article) }
    let(:attachment) { fixture_file_upload('spec/fixture_files/1.jpeg', 'image/png') }
    let!(:responsesss) do
      '{"data"=>{"id"=>"3O9qUDG", "title"=>nil, "description"=>nil,
      "datetime"=>1679576658, "type"=>"image/png", "animated"=>false,
      "width"=>1640, "height"=>1360, "size"=>285808, "views"=>0,
      "bandwidth"=>0, "vote"=>nil, "favorite"=>false, "nsfw"=>nil,
      "section"=>nil, "account_url"=>nil, "account_id"=>167916213,
      "is_ad"=>false, "in_most_viral"=>false, "has_sound"=>false,
      "tags"=>[], "ad_type"=>0, "ad_url"=>"", "edited"=>"0",
      "in_gallery"=>false, "deletehash"=>"AfDrw9HoJ8kQvHE", "name"=>"",
      "link"=>"https://i.imgur.com/3O9qUDG.png"}, "success"=>true, "status"=>200}'
    end
    let(:response) do
      {
        'data' => {
          'key' => 'value',
          'key2' => 'value2'
        }
      }
    end

    RSpec.configure do |config|
      config.before(:all) do
        stub_request(:post, 'https://api.imgur.com/3/upload.json')
          .to_return(body: '{"data":{"id":"3O9qUDG", "type":"image/png"}}', headers: { "Content-Type": 'application/json' })
      end
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
          post '/api/articles', params: { article: { description: article.description },
                                          attachment: }, headers:
        end.to change { Article.count }.by(1)
        expect(Article.last.status.to_s).to eq('draft')
      end
    end

    context 'When publisher user' do
      let(:user) { create(:user, :publisher) }
      it 'creates published article' do
        headers = { TOKEN: user.token }
        expect do
          post '/api/articles', params: { article: { description: article.description } }, headers:
        end.to change { Article.count }.by(1)
        expect(Article.last.status.to_s).to eq('published')
      end
    end

    context 'creates published articles' do
      let(:user) { create(:user, :admin) }
      it 'creates published articles' do
        headers = { TOKEN: user.token }
        expect do
          post '/api/articles', params: { article: { description: article.description } }, headers:
        end.to change { Article.count }.by(1)
        expect(Article.last.status.to_s).to eq('published')
      end
    end
  end
end
