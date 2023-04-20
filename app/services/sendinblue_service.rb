class SendinblueService
  def initialize(email,name)
    @email = email
    @first_name = name.split(' ')[0]
    @last_name = name.split(' ')[1]
  end

  def call
    api_instance = SibApiV3Sdk::ContactsApi.new
    create_contact = SibApiV3Sdk::CreateContact.new 
    contact = {
      'email' => @email,
      'attributes' => {
        'FIRSTNAME' => @first_name,
        'LASTNAME' => @last_name
      }
    }
		begin
			result = api_instance.create_contact(contact)
      p result
    rescue SibApiV3Sdk::ApiError => e
      Rails.logger.error "Exception when calling ContactsApi create_contact: #{e}"
    end
  end
end
  