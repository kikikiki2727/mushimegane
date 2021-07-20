module NewsHelper
  def get_news
    require 'net/https'
    require 'uri'
    require 'json'

    access_key = '95125e33b28c4c1eb536a40161798238'

    uri  = 'https://api.bing.microsoft.com/'
    path = '/v7.0/news/search'
    count = '20'
    term = '虫'

    uri = URI("#{uri}#{path}?count=#{count}&sortBy=date&q=#{CGI.escape(term)}")

    request = Net::HTTP::Get.new(uri)
    request['Ocp-Apim-Subscription-Key'] = access_key

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(request)
    end

    json_news_list = JSON.parse(response.body)
    json_news_list['value']
  end
end
