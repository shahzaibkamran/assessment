class UsersController < ApplicationController
  before_action :authenticate_user! 
  before_action :set_user, only: %i[ show update destroy]
  before_action :validate_user, only: %i[ show update destroy]
  before_action :validate_admin, only: %i[request_admin approve_user]
  
  def index
    @users = User.all
    render json: @users
  end

  def show
    render json: @user
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  def request_admin
   @user = User.requests

   if @user.count > 0
    render json: @user
  else
    render json: {message: "No user request(s) found"},status: :ok
  end

  end

  def approve_user 
    users = User.where(id: params[:request_ids])
    users.each {|user| user.update(role: "admin")}
    render json: {
      message: "Users promoted to admin"
    }
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:password, :password_confirmation,:request_ids)
    end
end
