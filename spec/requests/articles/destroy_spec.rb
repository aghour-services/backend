RSpec.describe 'ArticlesController', type: :request do
  let!(:article) {create(:article , :with_user)}

  describe '#destroy' do
      before do
        delete "/articles/#{article.id}"
      end
      it "deletes the article" do
        expect(Article.find_by(id: article.id)).to be_nil
        expect(response).to redirect_to(articles_path)
    end
  end
end
