RSpec.describe Device, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:token) }
  end

  describe '#time_ago' do
    context 'when last_usage_time is nil' do
      let(:device) { create(:device) }

      it 'returns nil time ago' do
        expect(device.time_ago).to be_nil
      end
    end

    context 'when last_usage_time is not nil' do
      let(:device) { create(:device, last_usage_time: 2.minutes.ago) }
      let(:result) { '2 دقيقة' }
      it 'returns text time ago' do
        expect(device.time_ago).to eq(result)
      end
    end
  end
end
