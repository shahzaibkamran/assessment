require 'httparty'

class NewsapiService
    
    def initialize(url,topic_id)
        @url = url
        @topic_id = topic_id
      end
    
    def call
        response = HTTParty.get(@url)
        puts "Response Status:" + response.code.to_s
        last_article_id = Article.last&.id unless Article.count == 0
        response['articles'].each do |article|
          if !article["author"].nil?
            id = Author.find_by_name(article["author"])&.id
            Author.create!(name:article["author"]) unless not id.nil? 
            id = Author.find_by_name(article["author"])&.id
            Article.create(title: article["title"], description: article["description"], content: article["content"], url: article["url"], urlToImage: article["urlToImage"], publishedAt: article["publishedAt"],topic_id: @topic_id,author_id: id) 
          end
        end
        return last_article_id
    end
end