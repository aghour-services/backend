RSpec.describe Attachment, type: :model do
    let(:article) { FactoryBot.create(:article, :with_user) }
    let(:attachment) { FactoryBot.create(:attachment, article: ) }

    describe "associations" do
        it { should belong_to(:article) }
    end

    describe "#resource_url" do
        it "returns the correct resource URL" do
            expect(attachment.resource_url).to eq("https://i.imgur.com/#{attachment.resource_id}.png")
        end
    end
end
