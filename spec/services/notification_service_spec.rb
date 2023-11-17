# frozen_string_literal: true

RSpec.describe NotificationService do
  describe '#send' do
    let(:data) { { title: 'Test Article', body: 'This is a test article.' } }
    let(:tokens) { ['test_token', 'test', 'token'] }
    let(:notification) { instance_double('Hash') }
    let(:fcm) { instance_double('FCM') }

    before do
      allow(Rails).to receive_message_chain(:env, :production?).and_return(true)
      allow(Rails.application.credentials).to receive(:fcm_server_key).and_return('test_key')
      allow_any_instance_of(NotificationService).to receive(:construct_notification_from_params).with(data).and_return(notification)
      allow(FCM).to receive(:new).with('test_key').and_return(fcm)
    end

    context 'when in production environment' do
      it 'sends a notification to the News-v1 topic' do
        expect(fcm).to receive(:send_to_topic).with('News-v2', notification)
        NotificationService.new(data).send_to_all
      end

      it 'sends a notification to custom tokens' do
        expect(fcm).to receive(:send).with(tokens, notification)
        NotificationService.new(data).send_to_custom(tokens)
      end
    end

    context 'when not in production environment' do
      before do
        allow(Rails).to receive_message_chain(:env, :production?).and_return(false)
      end

      it 'does not send a notification' do
        expect(fcm).not_to receive(:send_to_topic)
        NotificationService.new(data).send_to_all
      end

      it 'does not send a notification to custom tokens' do
        expect(fcm).not_to receive(:send)
        NotificationService.new(data).send_to_custom(tokens)
      end
    end
  end
end