class SendinblueWorker
    include Sidekiq::Worker
  
    def perform(email, name)
      sendinblue_service = SendinblueService.new(email, name)
      sendinblue_service.call
    end
  end