# RSpec.describe 'UsersController', type: :request do
#   let!(:user) {create(:user)}

#   describe '#destroy' do
#       before do
#         delete "/users/#{user.id}"
#       end
#       it "deletes the user" do
#         expect(User.find_by(id: user.id)).to be_nil
#         expect(response).to redirect_to(users_path)
#     end
#   end
# end
