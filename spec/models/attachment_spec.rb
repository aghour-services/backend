RSpec.describe Attachment, type: :model do
    describe "associations" do
        it { should belong_to(:article) }
    end
end
