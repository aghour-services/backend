# frozen_string_literal: true

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }


  context "validations" do
    it { is_expected.to validate_presence_of(:name) }
  end

  context "relations" do
    it { is_expected.to have_many(:articles) }
    it { is_expected.to have_many(:firms) }
  end

  context "#verified" do

    context 'when user role is user' do
      it do
        expect(user.verified?).to be false
      end
    end

    context 'when user role is publisher' do

      before {
        user.update(role: 1)
      }

      it do
        expect(user.verified?).to be true
      end
    end

    context "when user role is admin" do
      before {
        user.update(role: 2)
      }

      it do
        expect(user.verified?).to be true
      end
    end
  end
end
