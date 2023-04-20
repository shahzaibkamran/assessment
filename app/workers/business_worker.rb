class BusinessWorker
  include Sidekiq::Worker

  def perform
    url = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=#{ENV['NEWS_API_KEY']}"
    newsapi_service = NewsapiService.new(url,2)
    id = newsapi_service.call
    getcontactsfromlist_service = GetcontactsfromlistService.new
    contacts = getcontactsfromlist_service.call

    contacts.each do |emails|
      sendemail_service = SendemailService.new(emails[:email], "Latest Business Updates", id)
      sendemail_service.call
    end
  end
end
