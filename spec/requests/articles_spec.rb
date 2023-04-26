require 'rails_helper'

RSpec.describe "::Articles", type: :request do
  
  let(:headers) { { 'Content-Type' => 'application/json', 'Accept' => 'application/json' } }

  let(:admin_credentials) { {user: { email: 'admin@example.com', password: '123456' }}.to_json }

  let(:articles) {{article:{title:"hello"}}.to_json}

  describe "Articles" do
    it "Index authenticates and returns all articles present" do
      author = create(:author)
      topic = create(:topic)
      article = create(:article,author_id: author.id,topic_id: topic.id)
      user = create(:user,email:"admin@example.com",password:"123456",password_confirmation:"123456",confirmed_at: Time.now,role:"admin")
      post "/users/sign_in", params: admin_credentials, headers: headers
      headers["authorization"] = response.headers["authorization"]
      get articles_path, headers: headers
      expect(response).to have_http_status(200)
    end

    it "Update article details" do
      author = create(:author)
      topic = create(:topic)
      article = create(:article,author_id: author.id,topic_id: topic.id)

      user = create(:user,email:"admin@example.com",password:"123456",password_confirmation:"123456",confirmed_at: Time.now,role:"admin")
      post "/users/sign_in", params: admin_credentials, headers: headers
      headers["authorization"] = response.headers["authorization"]
      init_title = article.title
      patch "/articles/#{article.id}",params: articles, headers: headers
      binding.pry
      expect(init_title).not_to eq(JSON.parse(response.body)["title"])
      expect(response).to have_http_status(200)
    end
  end
end
