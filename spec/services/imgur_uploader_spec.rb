RSpec.describe ImgurUploader do
  let(:image_path) { "spec/fixture_files/1.jpeg" }

  describe ".upload" do
    it "uploads an image to Imgur" do
      stub_request(:post, "https://api.imgur.com/3/upload.json")
        .with(
          headers: {
            "Authorization" => ENV["IMGUR_CLIENT_ID"],
            "Authorization" => ENV["IMGUR_ACCESS_TOKEN"],
            },
        ).to_return(
          body: '{"data":{"id":"3O9qUDG", "type":"image/jpeg"}}',
        )

      imgur_data = ImgurUploader.upload(image_path)
      expect(imgur_data).to eq("id" => "3O9qUDG", "type" => "image/jpeg")
    end
  end
end
