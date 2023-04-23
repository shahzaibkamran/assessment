if Rails.env == "production"
    Searchkick.client = Elasticsearch::Client.new(hosts: [
        {
          host: ENV['ELASTIC_SEARCH_URL']
        }
      ], retry_on_failure: true, transport_options: {request: {timeout: 250}})
else
    url = 'http://localhost:9200/'
    Searchkick.client = Elasticsearch::Client.new(hosts: url, retry_on_failure: true, transport_options: {request: {timeout: 250}})
end
