require 'rails_helper'

RSpec.describe "::Users", type: :request do

  let(:reader_params) { {user: { email: 'reader_test@example.com', password: 'password', password_confirmation: 'password' , confirmed_at: Time.now,admin:true}}.to_json }

  let(:admin_params) { {user: { email: 'admin@example.com', password: 'password', password_confirmation: 'password' , confirmed_at: Time.now,role: 'admin'}}.to_json }

  let(:invalid_params) { {user: { email: 'test', password: 'password' }}.to_json }
  
  let!(:user_reader) { create(:user, email: 'reader@example.com', password: 'password', password_confirmation:'password',admin:true) }
  
  let!(:user_admin) { create(:user, email: 'admin@example.com', password: 'password', password_confirmation:'password',role:'admin') }

  let(:headers) { { 'Content-Type' => 'application/json', 'Accept' => 'application/json' } }

  let(:admin_credentials) { {user: { email: 'admin@example.com', password: 'password' }}.to_json }

  let(:invalid_credentials) { {user: { email: 'admin@example.com', password: 'wrong_password' }}.to_json }

  describe "POST /users" do
    it "Create user with valid params!" do
      post "/users", params: reader_params, headers: headers   
      expect(json['message']).to eq('Signed up sucessfully.')
      expect(response).to have_http_status(200  )
    end
  end

  describe "POST /users" do
    it "Create user with invalid params!" do
      post "/users", params: invalid_params, headers: headers   
      expect(json['message']).to eq('User could not be created successfully.')
      expect(response).to have_http_status(422)
    end
  end

  describe "POST /users" do
    it "Sign in user with valid params!" do
      post "/users/sign_in", params: admin_credentials, headers: headers
      expect(json['message']).to eq('You are logged in.')
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /users" do
    it "Sign in user with invalid credentials!" do
      post "/users/sign_in", params: invalid_credentials, headers: headers   
      expect(json['error']).to eq('Invalid Email or password.')
      expect(response).to have_http_status(401)
    end
  end

  describe "GET /users/requests" do
    it "Access a resource without authenticating" do
      get "/users/requests" , headers: headers   
      expect(json['error']).to eq('You need to sign in or sign up before continuing.')
      expect(response).to have_http_status(401)
    end
  end

  describe "GET /users/requests" do
    it "Access a resource after authenticating as admin" do
      post "/users/sign_in", params: admin_credentials, headers: headers
      headers["authorization"] = response.headers["authorization"]
      get "/users/requests" , headers: headers   
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /users/approve" do
    it "Approving readers" do
      post "/users/sign_in", params: admin_credentials, headers: headers
      headers["authorization"] = response.headers["authorization"]
      get "/users/requests" , headers: headers   
      id = JSON.parse(response.body)[0]["id"]
      approve_users = "{'user' => { 'request_ids' => [#{id}]}}".to_json
      total_count = User.where(role:"reader",admin:true).count
      post "/users/approve",params: {user:{request_ids: [id]}}.to_json, headers: headers   
      final_count = User.where(role:"reader",admin:true).count
      expect(total_count - 1).to eq(final_count)
      expect(json['message']).to eq('Users promoted to admin')
      expect(response).to have_http_status(200)
    end
  end
end