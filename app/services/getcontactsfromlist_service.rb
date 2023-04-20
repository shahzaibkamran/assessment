class GetcontactsfromlistService
  def call
    api_instance = SibApiV3Sdk::ContactsApi.new
    list_id = 2
    opts = {
        limit: 50, 
        offset: 0, 
        include_list_ids: [list_id],
    }

    begin
        result = api_instance.get_contacts_from_list(list_id, opts)
        contacts = result.contacts
    rescue SibApiV3Sdk::ApiError => e
        Rails.logger.error "Exception when calling ContactsApi->get_contacts_from_list: #{e}"
    end
  end
end
