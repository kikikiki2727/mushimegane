module NewsHelper
  def get_news
    require 'net/https'
    require 'uri'
    require 'json'

    accessKey = "95125e33b28c4c1eb536a40161798238"

    uri  = "https://api.bing.microsoft.com/"
    path = "/v7.0/news/search"
    count = "20"
    term = "虫"

    today = Date.today
    uri = URI(uri + path + "?count=" + count + "&sortBy=" + "date" + "&q=" + URI.escape(term))

    request = Net::HTTP::Get.new(uri)
    request['Ocp-Apim-Subscription-Key'] = accessKey

    response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
        http.request(request)
    end

    json_news_list = JSON.parse(response.body)
    news_list = json_news_list["value"]

    # news_list.each do |news|
    #   puts 'name : ' + news["name"]
    #   puts 'url : ' + news["url"]
    #   puts 'thumbnail : ' + news["image"]["thumbnail"]["contentUrl"] if news["image"]
    #   puts 
    # end
  end
end
