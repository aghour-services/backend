require "net/http"
require "uri"
require "base64"
require "json"

class ImgurUploader
  def self.upload(image_path)
    imagedata = Base64.encode64(File.read(image_path, mode: "rb"))
    url = "https://api.imgur.com/3/upload.json"
    params = { image: imagedata }
    uri = URI.parse(url)
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(uri.path)
    request["Authorization"] = "Client-ID 8e6a48d7dbd19d5"
    request["Authorization"] = "Bearer 3c14136738ece9b8ec5f1425b0af2587f84f8ba0"
    request.set_form_data(params)

    response = https.request(request)
    hash = JSON.parse(response.body)
    link = hash["data"]["link"]

    return link
  end
end
