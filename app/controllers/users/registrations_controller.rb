class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?

    if resource.persisted?
      if resource.active_for_authentication?
        sign_up(resource_name, resource)
        render json: {
          message: "Signed up successfully",
          user: resource,
        }, status: :ok
      else
        expire_data_after_sign_in!
        render json: {
          message: "Signed up successfully",
          user: resource,
        }, status: :ok
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      render json: {
        message: "Failed to sign up",
        errors: resource.errors,
      }, status: :unprocessable_entity
    end
  end

  def sign_up_params
    params.permit(:email, :password, :password_confirmation, :profile_pic)
  end
end
