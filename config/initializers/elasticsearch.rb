if Rails.env == "production"
    # Searchkick.client = Elasticsearch::Client.new url: ENV['ELASTIC_SEARCH_URL']
    Elasticsearch::Client.new url: ENV['ELASTIC_SEARCH_URL']
    Searchkick.client = Elasticsearch::Client.new(hosts: ENV['ELASTIC_SEARCH_URL'], retry_on_failure: true, transport_options: {request: {timeout: 250}})
else
    url = 'http://localhost:9200/'
    Elasticsearch::Client.new url: url
    Searchkick.client = Elasticsearch::Client.new(hosts: url, retry_on_failure: true, transport_options: {request: {timeout: 250}})
end
