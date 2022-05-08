# frozen_string_literal: true

RSpec.describe Category, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:icon) }
  end

  context 'relations' do
    it { is_expected.to have_many(:firms) }
  end
end
