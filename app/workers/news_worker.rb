class NewsWorker
  include Sidekiq::Worker

  def perform
    url = "https://newsapi.org/v2/everything?q=Imran+Khan&apiKey=#{ENV['NEWS_API_KEY']}"
    newsapi_service = NewsapiService.new(url,1)
    id = newsapi_service.call
    getcontactsfromlist_service = GetcontactsfromlistService.new
    contacts = getcontactsfromlist_service.call
    contacts.each do |emails|
      sendemail_service = SendemailService.new(emails[:email],"Latest news on Imran Khan",id)
      sendemail_service.call
    end

  end
end
  