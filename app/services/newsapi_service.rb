require 'httparty'

class NewsapiService
  def initialize(url,topic_id)
    @url = url
    @topic_id = topic_id
  end
  
  def call
    response = HTTParty.get(@url)
    puts "Response Status:" + response.code.to_s
    last_article_id =  Article.count > 0 ? Article.last&.id : 0

    response['articles']&.each do |article|
      if article["author"].present?
        author = Author.find_by_name(article["author"])
        author = author.nil?? Author.create!(name:article["author"]) : author
        Article.create(title: article["title"], description: article["description"], content: article["content"], url: article["url"], urlToImage: article["urlToImage"], publishedAt: article["publishedAt"],topic_id: @topic_id,author_id: author.id) 
      end
    end

    return last_article_id
  end
end
