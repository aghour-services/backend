RSpec.describe Device, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:token) }
  end
end
