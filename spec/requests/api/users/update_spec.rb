RSpec.describe "Api::Users::RegistrationsController", type: :request do
    let(:imgur_response) do
        '{"data":{"id":"3O9qUDG", "type":"image/png"}, "success": true}'
      end
    let(:user) { create(:user) }
    let(:headers) { { TOKEN: user.token } }
    let(:avatar) { fixture_file_upload('spec/fixture_files/1.jpeg', 'image/png') }
      
    before do
        stub_request(:post, 'https://api.imgur.com/3/upload.json')
        .to_return(body: imgur_response,
                    headers: { "Content-Type": 'application/json' })
    end

    before do
        sign_in user
    end

    describe "#update" do
        context "valid params with profile owner" do
            it "updates user name" do
                expect do
                    user.name = 'new name'
                    user_params = user.attributes.symbolize_keys
                    put "/api/users", params: { user: user_params }, headers: headers
                    expect(response).to have_http_status(200)
                end.to change { user.name }.to("new name")
            end

            it "updates user avatar" do
                expect do
                    user.avatar = avatar
                    user_params = user.attributes.symbolize_keys
                    put "/api/users", params: { user: user_params }, headers: headers
                    expect(response).to have_http_status(200)
                    expect(user.avatar).not_to be_nil
                end
            end
        end

        xcontext "valid params with not profile owner" do
            it "doesn't update user name" do
                expect do
                    user.name = 'new name'
                    user_params = user.attributes.symbolize_keys
                    put "/api/users", params: { user: user_params }, headers: { TOKEN: "token" }
                    expect(response).to have_http_status(401)
                end.not_to change { user.name }
            end
        end
    end
end

  