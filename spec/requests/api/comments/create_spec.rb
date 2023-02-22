RSpec.describe "Api::Comments", type: :request do
    let(:user) { create(:user) }
    let(:article) { create(:article, user:) }
    let(:comment) { build(:comment) }

    context "with valid userl" do
        it "creates a comment" do
            headers = { TOKEN: user.token }
            comment_params = { comment: comment.attributes.merge(user_id: user.id) }
            expect do
            post "/api/articles/#{article.id}/comments", params: comment_params, headers: headers
            end.to change { Comment.count }.by(1)
        end
    end

    context "with invalid user" do
        it "doesn't create a comment" do
            headers = { TOKEN: nil }
            comment_params = { comment: comment.attributes.merge(user_id: user.id) }
            expect {
                post "/api/articles/#{article.id}/comments", params: comment_params, headers: headers
                expect(response).to have_http_status(:unauthorized)
            }.not_to change { Comment.count }
        end
    end
end
