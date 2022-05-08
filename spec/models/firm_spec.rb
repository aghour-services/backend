# frozen_string_literal: true

RSpec.describe Firm, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:phone_number) }
  end

  context 'relations' do
    it { is_expected.to belong_to(:category) }
  end
end
