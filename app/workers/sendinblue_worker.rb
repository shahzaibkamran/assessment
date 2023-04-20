class SendinblueWorker
  include Sidekiq::Worker

  def perform(email, name)
    createcontact_service = SendinblueService.new(email, name)
    createcontact_service.call
    addtolist_service = AddtolistService.new(email)
    addtolist_service.call
  end
end