class Users::RegistrationsController < Devise::RegistrationsController
    respond_to :json
  
    private
  
    def respond_with(resource, _opts = {})
      register_success && return if resource.persisted?
      err = resource.errors.full_messages
      register_failed err
    end
  
    def register_success
      render json: { message: 'Signed up sucessfully.',data: current_user },status: :ok
    end
  
    def register_failed(err)
      render json: { message: "User could not be created successfully.",errors: err},status: :unprocessable_entity
    end
end