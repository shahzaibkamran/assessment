class SendemailService
    def initialize(email,subject,content)
        @email = email
        @subject = subject
        @content = content
      end
    
    def call
        api_instance = SibApiV3Sdk::TransactionalEmailsApi.new
        html_content = "<html><body>"
        contents = Article.where(id:@content+1..) 
        contents.each do |article|
            html_content += "<h1>Topic: #{article.topic.category}</h1><h2>Title: #{article.title}</h2><h2>URL: #{article.url}</h2><h2>URL Image: #{article.urlToImage}</h2><h2>Description: #{article.description}</h2><p>Content: #{article.content&.truncate(100000)}</p>"
        end 
        html_content += "</body></html>"

        send_smtp_email = {
            'subject'=> @subject,
            'htmlContent'=> html_content,
            'sender'=> {
              'name'=>  ENV['SENDINBLUE_NAME'],
              'email'=> ENV['SENDINBLUE_EMAIL']
            },
            'to'=> [{'email'=>@email}],
          }
        begin
            result = api_instance.send_transac_email(send_smtp_email)
            puts result
        rescue SibApiV3Sdk::ApiError => e
          Rails.logger.error "Exception when calling TransactionalEmailsApi->send_transac_email: #{e.response_body}"
        end
    end
end