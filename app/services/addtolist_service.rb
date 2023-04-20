class AddtolistService
    def initialize(email)
      @email = email
    end
  
    def call
      api_instance = SibApiV3Sdk::ContactsApi.new
      add_contact_to_list = SibApiV3Sdk::AddContactToList.new
      list_id = 2
      contact_emails = SibApiV3Sdk::AddContactToList.new
      contact_emails = {'emails' => [@email]}
      begin
        result = api_instance.add_contact_to_list(list_id, contact_emails)
        p result
      rescue SibApiV3Sdk::ApiError => e
        Rails.logger.error "Exception when calling ContactsApi create_contact: #{e}"
      end
    end
  end
    