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
      if article["author"].present?
        id = Author.find_by_name(article["author"])&.id
        author = Author.create!(name:article["author"]) if id.nil? 
        Article.create(title: article["title"], description: article["description"], content: article["content"], url: article["url"], urlToImage: article["urlToImage"], publishedAt: article["publishedAt"],topic_id: @topic_id,author_id: author.id) 
      end
    end

    return last_article_id
  end
end
