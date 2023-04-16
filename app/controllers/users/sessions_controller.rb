class Users::SessionsController < Devise::SessionsController
    respond_to :json
  
    private
  
    def respond_with(resource, _opts = {}) 
      render json: { message: 'You are logged in.',data: current_user }, status: :ok
    end
  
    def respond_to_on_destroy
      jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1],ENV['JWT_SECRET_KEY']).first
      current_user = User.find(jwt_payload['sub'])
      log_out_success && return if current_user
      log_out_failure
    end
  
    def log_out_success
      render json: { message: "You are logged out." }, status: :ok
    end
  
    def log_out_failure
      render json: { message: "User has no active session"}, status: :unauthorized
    end
end