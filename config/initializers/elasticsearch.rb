if Rails.env == "production"
    Searchkick.client = Elasticsearch::Client.new(hosts: [
        {
          host: ENV['ELASTIC_SEARCH_URL'],
          scheme: 'https',
          path: '',
          port: 443,
          user: ENV['ELASTIC_SEARCH_USERNAME'],
          password: ENV['ELASTIC_SEARCH_PASSWORD']
        }
      ], retry_on_failure: true, transport_options: {request: {timeout: 250}})
else
    url = 'http://localhost:9200/'
    Searchkick.client = Elasticsearch::Client.new(hosts: url, retry_on_failure: true, transport_options: {request: {timeout: 250}})
end
