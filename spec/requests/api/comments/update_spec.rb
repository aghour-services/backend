RSpec.describe "Api::Comments", type: :request do
    let(:user) { create(:user) }
    let(:article) { create(:article, user:) }
    let(:comment) { create(:comment, article: , user:) }

    describe '#update' do
        context "with valid user" do
            it "updates a comment" do
                headers = { TOKEN: user.token }
                comment.update(body: "new comment", article_id: article.id, user_id: user.id)
                comment_params = { comment: comment.attributes.merge(user_id: user.id) }
                put "/api/articles/#{article.id}/comments/#{comment.id}", params: comment_params, headers: headers
                comment.reload
                expect(response).to have_http_status(:ok)
            end
        end

        context "with valid user" do
            it "updates a comment" do
                headers = { TOKEN: nil }
                comment.update(body: "new comment", article_id: article.id, user_id: user.id)
                comment_params = { comment: comment.attributes.merge(user_id: user.id) }
                put "/api/articles/#{article.id}/comments/#{comment.id}", params: comment_params, headers: headers
                comment.reload
                expect(response).to have_http_status(:unauthorized)
            end
        end
    end
end
