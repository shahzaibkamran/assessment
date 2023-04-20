class ApplicationController < ActionController::API
  before_action :authenticate_user!
  
  private

  def validate_user
    return render json: {message: "You can only change your own details."}, status: :forbidden unless current_user.id == params[:id].to_i
  end

  def validate_admin
    return render json: { message: "Only admins can access this route "},status: :forbidden unless current_user.role == "admin"
  end
end

