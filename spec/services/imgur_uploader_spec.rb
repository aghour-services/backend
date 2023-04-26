RSpec.describe ImgurUploader do
  let(:image_path) { 'spec/fixture_files/1.jpeg' }
  let(:expected_response) do
    { 'data' => { 'id' => '3O9qUDG', 'type' => 'image/png' }, 'success' => true }
  end

  let(:imgur_response) do
    '{"data":{"id":"3O9qUDG", "type":"image/png"}, "success": true}'
  end

  describe '.upload' do
    before do
      stub_request(:post, 'https://api.imgur.com/3/upload.json')
        .to_return(body: imgur_response,
                   headers: { "Content-Type": 'application/json' })
    end
    it 'uploads an image to Imgur' do
      imgur_data = ImgurUploader.upload(image_path)
      expect(imgur_data).to eq(expected_response)
    end
  end
end
