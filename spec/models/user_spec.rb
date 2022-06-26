# frozen_string_literal: true

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }

  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  context 'relations' do
    it { is_expected.to have_many(:articles) }
    it { is_expected.to have_many(:firms) }
  end
end
