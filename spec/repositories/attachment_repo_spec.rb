RSpec.describe AttachmentRepo, type: :repo do
  let(:article) { FactoryBot.create(:article, :with_user) }
  let(:attachment) { FactoryBot.create(:attachment, :with_article) }
  let(:attachment_repo) { AttachmentRepo.new(article, attachment.raw_response, attachment.resource_id, attachment.resource_type) }

  describe "#create_attachment" do
    it "creates a new attachment and returns its resource URL" do
      expect {
        attachment_repo.create_attachment
      }.to change { article.attachments.count }.by(1)

      last_attachment = article.attachments.last
      expect(last_attachment.raw_response).to eq(attachment.raw_response)
      expect(last_attachment.resource_id).to eq(attachment.resource_id)
      expect(last_attachment.resource_type).to eq(attachment.resource_type)

      resource_url = "#{Attachment::BASE_URL}#{last_attachment.resource_id}.#{last_attachment.resource_type.split("/").last}"
      expect(attachment.resource_url).to eq(resource_url)
    end
  end
end
