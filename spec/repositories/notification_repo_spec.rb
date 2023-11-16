RSpec.describe NotificationRepo, type: :repo do
    let(:user) { create(:user) }
    let(:article) { create(:article, user: user)}
    let(:notification_repo) { NotificationRepo.new(article, user, 'notification.title', 'notification.body', nil) }

    describe "#create" do
        it "creates a new notification" do
            expect {
                notification_repo.create
            }.to change { Notification.count }.by(1)

            last_notification = Notification.last
            expect(last_notification.title).to eq('notification.title')
            expect(last_notification.body).to eq('notification.body')
            expect(last_notification.notifiable_type).to eq('Article')
            expect(last_notification.notifiable_id).to eq(article.id)
            expect(last_notification.user_id).to eq(user.id)
        end
    end
end
