require "uri"
require "net/http"

class ImgurUploader
    def self.upload(image)
         url = URI("https://api.imgur.com/3/image")

        https = Net::HTTP.new(url.host, url.port)
        https.use_ssl = true

        request = Net::HTTP::Post.new(url)
        request["Authorization"] = "Client-ID {{clientId}}"
        form_data = [["image", "R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7"]]
        request.set_form form_data, "multipart/form-data"
        response = https.request(request)
        puts response.read_body
    end
end




