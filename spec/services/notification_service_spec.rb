# frozen_string_literal: true

RSpec.describe NotificationService do
  describe '#send' do
    let(:data) { { title: 'Test Article', body: 'This is a test article.' } }
    let(:notification) { instance_double('Hash') }
    let(:fcm) { instance_double('FCM') }

    before do
      allow(Rails).to receive_message_chain(:env, :production?).and_return(true)
      allow(Rails.application.credentials).to receive(:fcm_server_key).and_return('test_key')
      allow_any_instance_of(NotificationService).to receive(:construct_notification_from_params).with(data).and_return(notification)
      allow(FCM).to receive(:new).with('test_key').and_return(fcm)
    end

    it 'sends a notification to the News-v2 topic' do
      expect(fcm).to receive(:send_to_topic).with('News-v2', notification)
      NotificationService.new(data).send
    end

    context 'when not in production environment' do
      before do
        allow(Rails).to receive_message_chain(:env, :production?).and_return(false)
      end

      it 'does not send a notification' do
        expect(fcm).not_to receive(:send_to_topic)
        NotificationService.new(data).send
      end
    end
  end
end